//
//  UIInitTableViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UIInitTableViewController.h"
#import "DBQueryInterface.h"
#import "FakeDB.h"
#import "UIJoinActivityViewController.h"
#import "TabbarViewController.h"
#import "RecipeViewController.h"
#import "UICompleteViewController.h"
#import "DetailPageViewController.h"
#import "huwAppDelegate.h"

@interface UIInitTableViewController ()

@property (strong,nonatomic)id <DBQueryInterface> Database;
@property (strong,nonatomic)NSArray* CreatedAcitivities;
@property (strong,nonatomic)NSArray* JoinedAcitivities;
@property (strong,nonatomic)NSIndexPath* path;

@end

@implementation UIInitTableViewController


enum AcitivityType
{
    Created,
    Join,
    TypeCount,
};

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add:)];
        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Share" action:@selector(share:)];
        UIMenuItem *menuItem2 = [[UIMenuItem alloc] initWithTitle:@"Detail" action:@selector(detail:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menuItem,menuItem2,nil] ];
        [[UIMenuController sharedMenuController] update];

        
    }
    return self;
}



-(IBAction)Add:(id)sender
{
    [self performSegueWithIdentifier:@"CreateActivity" sender:self];
}

- (BOOL)canBecomeFirstResponder {
    // NOTE: This menu item will not show if this is not YES!
    return YES;
}

- (void)viewDidLoad
{
    [self updateView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:USER_PLIST];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: USER_PLIST] ];
    }
    
    NSMutableDictionary *data;
    
    if ([fileManager fileExistsAtPath: path])
    {
        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        
        NSLog(@"id :%@, name:%@",data[USER_ID],data[USER_NAME]);
        
        [huwAppDelegate setFB_ID:data[USER_ID]];
        [huwAppDelegate setFB_Name:data[USER_NAME]];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            
            self.Database = [FakeDB GetDBInstance];
            self.CreatedAcitivities = [self.Database GetCreatedActivity : [huwAppDelegate FB_ID]];
            self.JoinedAcitivities = [self.Database GetJoinedActivity : [huwAppDelegate FB_ID]];
            
            
            [self.tableView reloadData];
        });
    }
    

    

    
   /* else
    {
        // If the file doesn’t exist, create an empty dictionary
        data = [[NSMutableDictionary alloc] init];
    }*/
    
    //To insert the data into the plist
    //int value = 5;
    
    /*
    [data setObject:@"Wang Han-Yu" forKey:USER_NAME];
    [data setObject:@"100002002364018" forKey:USER_ID];
    
    [data writeToFile: path atomically:YES];
    
    NSLog(@"setData");
     */

    //To reterive the data from the plist
    /*
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    int value1;
    value1 = [[savedStock objectForKey:@"value"] intValue];
    NSLog(@"%i",value1);
    [savedStock release];
     */
    
    
    
   // facebook login
   /*
    huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                [self updateView];
                
            }];
        }
    }*/
    

}



-(void) share: (id) sender {
    
    NSDictionary* targetActivity;
    
    if(self.path.section == 0)
    {
        targetActivity = self.CreatedAcitivities[self.path.row];
    }
    else if(self.path.section == 1)
    {
        targetActivity = self.JoinedAcitivities[self.path.row];
    }
    
    NSString* activityID = targetActivity[@"id"];
    UICompleteViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Share"];
    
    controller.ActivityID = activityID;
    
    controller.share = true;
    
    [self.navigationController pushViewController:controller animated:YES];

}


-(void) detail:(id) sender {
    
 [self performSegueWithIdentifier:@"Detail" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.JoinedAcitivities == nil)return 0;
    
    return TypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 0;
    
    
    
    switch (section)
    {
        case Created:
            return [self.CreatedAcitivities count];
            break;
        case Join:
            return [self.JoinedAcitivities count];
            break;
        default:
            return 0;
            break;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* target;
    NSString* statusStr;
    NSString* cellType;
    
    switch (indexPath.section)
    {
        case Created:
            
            target = self.CreatedAcitivities[indexPath.row];
           
            break;
        case Join:

            target = self.JoinedAcitivities[indexPath.row];
            break;
        default:

            target = @{@"id":@(9999),@"name":@"undifined",@"status":@(ASFailed)};
            cellType = @"SuccessActivity";
            break;
    }
    
    
    NSNumber *statusNumber = target[@"status"];
    
    switch ([statusNumber intValue]) {
        case ASRecruting:
            statusStr = @"招募中";
             cellType = @"OtherActivity";
            break;
        case ASSuccess:
            statusStr = @"成功";
            
            
            if(indexPath.section == Created)
            {
                cellType = @"SuccessActivity";
            }
            else if(indexPath.section == Join)
            {
                cellType = @"JoinedSuccessActivity";
            }
            
            break;
        case ASFailed:
            statusStr = @"流團";
             cellType = @"OtherActivity";
            break;
        default:
            break;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType forIndexPath:indexPath];
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
    UILabel* statusLabel = (UILabel*)[cell viewWithTag:2];
    
    nameLabel.text = target[@"name"];

    statusLabel.text = statusStr;

    UILongPressGestureRecognizer * longPressGesture =   [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];

    
    return cell;
}

- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"long pressed");
        
        
        UITableViewCell *cell = recognizer.view;
        
        self.path = [self.tableView indexPathForCell:cell];
        
        
        CGPoint p =[recognizer locationInView:self.view];
        
        CGRect rect = CGRectMake(p.x, recognizer.view.frame.origin.y,-20, 0);
        
        [[UIMenuController sharedMenuController] setTargetRect:rect inView:self.view];
        
        [[UIMenuController sharedMenuController] setMenuVisible:true animated:YES];
        

    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case Created:
            return @"我建立的";
            break;
        case Join:
            return @"我參加的";
            break;
        default:
            return @"其他";
            break;
    }
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"hostDetail"])
    {
        TabbarViewController *viewController = segue.destinationViewController;
        
        NSIndexPath * path = [self.tableView indexPathForCell:sender];
        NSString* ActivityID = self.CreatedAcitivities[path.row][@"id"];
        
        dispatch_async( dispatch_get_main_queue(), ^{

        NSDictionary* activityDetail = [self.Database GetActivityDetail:ActivityID];
        NSArray* buyList = [self.Database GetBuyList:ActivityID];
            
            viewController.activityDetail = activityDetail;
            viewController.buyList = buyList;
            
            [viewController updateData];
            
        });
        

    }
    else if([segue.identifier isEqual:@"joinDetail"])
    {
     
            RecipeViewController* recipe = segue.destinationViewController;
            
            NSIndexPath* path =  [self.tableView indexPathForCell:sender];
        
           NSString* ActivityID = self.JoinedAcitivities[path.row][@"id"];
        NSString* OrderID = self.JoinedAcitivities[path.row][@"orderid"];
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            NSDictionary* detail = [self.Database GetActivityDetail:ActivityID];
            NSArray* buyList = [self.Database GetBuyList:ActivityID];
            
            
            //for()
            
            NSDictionary* buyEntry = [self.Database GetTargetOrderList:OrderID];
            
            recipe.activityDetail = detail;
            recipe.buyList = buyList;
            recipe.buyEntry = buyEntry;
   
            
            NSLog(@"data get");
            [recipe updateData];
        });

        recipe.mode = forJoin;

    }
    else if([segue.identifier isEqual:@"OpenURL"])
    {
       UIJoinActivityViewController* join =  segue.destinationViewController;
        join.Join = true;
        NSLog(@"OpenURL");
    }
    else if([segue.identifier isEqual:@"Detail"])
    {
        
        DetailPageViewController* detail =  segue.destinationViewController;
        
        if(self.path.section == 0)
        {
             detail.ActivityDetail = self.CreatedAcitivities[self.path.row];
        }
        else if(self.path.section == 1)
        {
               detail.ActivityDetail = self.JoinedAcitivities[self.path.row];
        }
        
    }
}



- (void)updateView {
    // get the app delegate, so that we can reference the session property
    huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        NSString* getURL = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",appDelegate.session.accessTokenData.accessToken];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getURL]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:10];
        [request setHTTPMethod: @"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

            
            
            [self.LoginButton setTitle:jsonDictionary[@"name"] forState:UIControlStateNormal];
            
            NSLog(@"User Id:%@",jsonDictionary[@"id"]);
            NSLog(@"User Name:%@",jsonDictionary[@"name"]);
            
        }];
        

        
    } else {
        

         [self.LoginButton setTitle:@"Guest" forState:UIControlStateNormal];
    }
}




- (IBAction)Login:(id)sender {
    huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        
        NSLog(@"logOut");
        
        [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        NSLog(@"logIn");
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            
            [self updateView];
        }];
    }

}




@end
