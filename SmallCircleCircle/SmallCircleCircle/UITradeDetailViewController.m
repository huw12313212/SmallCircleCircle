//
//  UITradeDetailViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UITradeDetailViewController.h"
#import "UINewTradeDetailViewController.h"
#import "FakeDB.h"
#import "UICompleteViewController.h"
#import "huwAppDelegate.h"
@interface UITradeDetailViewController ()


@property (strong,nonatomic)NSObject<DBQueryInterface> *Database;

@end

@implementation UITradeDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if(self.EntryList==nil)
    {
        self.EntryList = [[NSMutableArray alloc]init];
    }
    
    self.Database = [FakeDB GetDBInstance];
    
    if(!self.Creating)
    {
        [self.tableView setContentInset:UIEdgeInsetsMake(66,0,0,0)];
    }
    else
    {
        [self.tableView setContentInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    
    
    huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
            }];
        }
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int data =[self.EntryList count];
    
    if(self.Creating)
    {
    data+=1;
    }
    return data;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.EntryList count])
    {
        return 44;
    }
    else
    {
        return 70;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *CellIdentifier;
    if(indexPath.row == [self.EntryList count])
    {
        CellIdentifier = @"New";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    }
    else
    {
        CellIdentifier = @"Entry";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel* locationLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* timeLabel = (UILabel*)[cell viewWithTag:2];
        
        locationLabel.text = self.EntryList[indexPath.row][@"location"];
        timeLabel.text = self.EntryList[indexPath.row][@"date"];
        
        cell.editing = true;
    }
    
    return cell;
}

- (IBAction)FinishClicked:(UIBarButtonItem *)sender
{

    
    if(self.EntryList.count < 1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"請輸入至少一個取貨時段" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        sender.enabled = NO;
        huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        if (appDelegate.session.isOpen) {

            [self updateView];

            
        } else {
            if (appDelegate.session.state != FBSessionStateCreated) {
                // Create a new, logged out session.
                
                  NSLog(@"case1");
                appDelegate.session = [[FBSession alloc] init];
                
              
            }
            
            NSLog(@"logIn");
            
            // if the session isn't open, let's open it now and present the login UX to the user
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                
                  NSLog(@"case2");
                [self updateView];
            }];
        }

        
        
        
    }
    
}


- (void)updateView {
    // get the app delegate, so that we can reference the session property
    huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        
        //NSLog(@"%@",appDelegate.session.accessTokenData.accessToken);
        NSString* getURL = [NSString stringWithFormat:@"https://graph.facebook.com/me?fields=id,name&access_token=%@",appDelegate.session.accessTokenData.accessToken];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getURL]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:10];
        [request setHTTPMethod: @"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            

            NSLog(@"User Id:%@",jsonDictionary[@"id"]);
            NSLog(@"User Name:%@",jsonDictionary[@"name"]);
            
            
            
             dispatch_async( dispatch_get_main_queue(), ^{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:USER_PLIST];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if (![fileManager fileExistsAtPath: path])
            {
                path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: USER_PLIST] ];
            }
            
            NSMutableDictionary *userData = [[NSMutableDictionary alloc]init];
            
            
            [userData setObject:jsonDictionary[@"id"] forKey:USER_ID];
            [userData setObject:jsonDictionary[@"name"] forKey:USER_NAME];
            
            
            [userData writeToFile: path atomically:YES];
             });
            
            [huwAppDelegate setFB_ID: jsonDictionary[@"id"]];
            [huwAppDelegate setFB_Name: jsonDictionary[@"name"]];
            
            
             self.navigationItem.rightBarButtonItem.enabled = true;
            
        
            [self performSegueWithIdentifier:@"Next" sender:nil];
            
        }];
        
        
        
    } else {
        
       // self.navigationItem.rightBarButtonItem.enabled = true;
        
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.EntryList count] == indexPath.row)
    {
        return UITableViewCellEditingStyleNone;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if([self.EntryList count] == indexPath.row)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        [self.EntryList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"New"])
    {
        UINewTradeDetailViewController* newItemView = segue.destinationViewController;
        newItemView.Entries = self.EntryList;
        newItemView.parentView = self;
    }
    else if([segue.identifier  isEqual: @"Next"])
    {
        
        [self.dictionary setObject:self.EntryList forKey:@"tradeDates"];
        [self.dictionary setObject:[huwAppDelegate FB_Name] forKey:@"userName"];
        
        NSString* activityID = [self.Database CreateActivity: [huwAppDelegate FB_ID] :self.dictionary];
        
        [huwAppDelegate setDirty:YES];
        
        UICompleteViewController* controller = segue.destinationViewController;
        
        controller.ActivityID = activityID;
        controller.share = false;
        
        NSLog(@"upload done , and performing Segue");
        
        
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)updateData
{
    
    
    [self.tableView reloadData];
}



@end
