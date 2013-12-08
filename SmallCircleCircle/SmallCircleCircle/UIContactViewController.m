//
//  UIContactViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/18.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UIContactViewController.h"
#import "FakeDB.h"
#import "huwAppDelegate.h"

@interface UIContactViewController ()

@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak,nonatomic) NSObject<DBQueryInterface>* DataBase;

@end

@implementation UIContactViewController


- (IBAction)ClickFinish:(id)sender {
    
    
    NSString* phoneRegEx= @"^\\(?(\\d{2})\\)?[\\s\\-]?(\\d{4})\\-?(\\d{4})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    
    
    if(![phoneTest evaluateWithObject:self.PhoneNumber.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"聯絡資訊" message:@"請填寫手機號碼" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        if (appDelegate.session.isOpen) {
            
            [self updateView];
            
            
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
            
            
            NSLog(@"User Id:%@",jsonDictionary[@"id"]);
            NSLog(@"User Name:%@",jsonDictionary[@"name"]);
            
            
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
            
            [huwAppDelegate setFB_ID: jsonDictionary[@"id"]];
            [huwAppDelegate setFB_Name: jsonDictionary[@"name"]];
            

            
            [self UploadData];
            
               dispatch_async( dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
               });
            
        }];
        
    } else {
        
        
    }
}



- (void)UploadData
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc]init];
    
    [dictionary setObject:self.ActivityDetail[@"id"] forKey:@"activityID"];
    [dictionary setObject:self.BuyAmountArray forKey:@"buyList"];
    [dictionary setObject:self.PhoneNumber.text forKey:@"phone"];
    
    [dictionary setObject:self.Date forKey:@"date"];
    [dictionary setObject:self.Location forKey:@"location"];
    
    [dictionary setObject:[huwAppDelegate FB_Name] forKey:@"userName"];
    
    [self.DataBase JoinActivity: [huwAppDelegate FB_ID]:self.ActivityDetail[@"id"]:dictionary];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.DataBase = [FakeDB GetDBInstance];
    self.LocationLabel.text = self.Location;
    self.DateLabel.text = self.Date;
    
    //self.Location
    
    
    
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
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
