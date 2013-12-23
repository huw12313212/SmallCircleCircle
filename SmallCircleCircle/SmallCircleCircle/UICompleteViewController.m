//
//  UICompleteViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UICompleteViewController.h"
#import "DBQueryInterface.h"
#import "FakeDB.h"
#import <FacebookSDK/FacebookSDK.h>
#import "huwAppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface UICompleteViewController ()


@property (strong,nonatomic)id <DBQueryInterface> Database;
@end

@implementation UICompleteViewController
- (IBAction)ClickOK:(id)sender {
    

    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)InviteClicked:(id)sender {
    NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys: nil];
    
    
    huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];

    [FBWebDialogs
     presentRequestsDialogModallyWithSession:appDelegate.session
     message:[NSString stringWithFormat:@"來參加我的團購：http://eva0919.github.io/SCC/index?url=SCC:\\\\%@", self.ActivityID]
     title:@"團購小圈圈"
     parameters:nil
     handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or sending the request.
             NSLog(@"Error sending request.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled request.");
             } else {
                 // Handle the send request callback
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 
                 NSLog(@"%@",urlParams);
                 
                 if (![urlParams valueForKey:@"request"]) {
                     // User clicked the Cancel button
                     NSLog(@"User canceled request.");
                 } else {
                     // User clicked the Send button
                     NSString *requestID = [urlParams valueForKey:@"request"];
                     NSLog(@"Request ID: %@", requestID);
                     
                     
                     
                     NSMutableArray* list = [[NSMutableArray alloc]init];
                     
                     bool skip = YES;
                     
                     for(NSObject* key in [urlParams allKeys])
                     {
                         if(skip)
                         {
                             skip = NO;
                             continue;
                         }

                             [list addObject:[NSString stringWithFormat:@"%@@facebook.com",
                              urlParams[key]]];

                     }
                     
                     
                   //  NSLog();
                     /*
                     MFMailComposeViewController *mailComposer;
                     mailComposer  = [[MFMailComposeViewController alloc] init];
                     mailComposer.mailComposeDelegate = self;
                     [mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
                     [mailComposer setSubject:@"團購小圈圈"];
                     [mailComposer setToRecipients:list];
                     [mailComposer setMessageBody:[NSString stringWithFormat:@"來參加我的團購：scc://%@", self.ActivityID] isHTML:NO];
                     [self presentModalViewController:mailComposer animated:YES];

                     */
                 }
             }
         }
     }];

}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if(error) NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
    [self dismissModalViewControllerAnimated:YES];
    return;
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


- (IBAction)Copy:(id)sender {
    
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =self.URLButton.titleLabel.text;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"複製完成" message:@"已複製連結，請分享給您的團購好友。" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)viewDidLoad
{
    
    if(self.share)
    {
        self.navigationItem.title = @"分享";
    }
    else
    {
        self.navigationItem.title = @"建立成功";
    }
    

    [self.URLButton setTitle:[NSString stringWithFormat:@"http://eva0919.github.io/SCC/index?url=SCC:\\\\%@", self.ActivityID] forState:UIControlStateNormal];
     //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.Database = [FakeDB GetDBInstance];
    
    self.navigationItem.hidesBackButton = YES;
    
    [super viewDidLoad];
   	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
