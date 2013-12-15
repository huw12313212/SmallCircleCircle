//
//  DetailPageViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/23.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "DetailPageViewController.h"
#import "UIJoinActivityViewController.h"
#import "UIItemViewController.h"
#import "FakeDB.h"
#import "huwAppDelegate.h"
#import "UITradeDetailViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>


@interface DetailPageViewController ()

@property NSArray* DetailControllers;

@end

@implementation DetailPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) Action: (id) sender
{
    NSLog(@"Share");
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet addButtonWithTitle:@"Copy Link"];
    [actionSheet addButtonWithTitle:@"Invite People"];
    [actionSheet addButtonWithTitle:@"Facebook"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    
    //[UIActionSheet alloc] init
    [actionSheet showInView:self.view];
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



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"test %i",buttonIndex);
    
    if(buttonIndex == 0)
    {
        
        //NSLog(@"%@",self.ActivityDetail);
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.URL =[NSURL URLWithString:[NSString stringWithFormat:@"scc://%@", self.ActivityDetail[@"id"]]];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"複製完成" message:@"已複製連結，請分享給您的團購好友。" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(buttonIndex == 1)
    {
        
        huwAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        

        [FBWebDialogs
         presentRequestsDialogModallyWithSession:appDelegate.session
         message:[NSString stringWithFormat:@"來參加我的團購：scc://%@", self.ActivityDetail[@"id"]]
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
    else if(buttonIndex == 2)
    {
            
            SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        
        NSString* text = [NSString stringWithFormat:@"來參加我的團購小圈圈！scc://%@",self.ActivityDetail[@"id"]];
        
            [mySLComposerSheet setInitialText:text];
            
            
            [mySLComposerSheet addURL:[NSURL URLWithString:[NSString stringWithFormat:@"scc://%@", self.ActivityDetail[@"id"]]]];
            
            [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        NSLog(@"Post Canceled");
                        break;
                    case SLComposeViewControllerResultDone:
                        NSLog(@"Post Sucessful");
                        break;
                        
                    default:
                        break;
                }
            }];
            
            [self presentViewController:mySLComposerSheet animated:YES completion:nil];

    }
}

- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(Action:)];
    
    [huwAppDelegate setOpenId:self.ActivityDetail[@"id"]];

    self.dataSource = self;

    
    UIJoinActivityViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetail"];
    [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    
   
    UIItemViewController *ItemsController = [self.storyboard instantiateViewControllerWithIdentifier:@"Items"];
    ItemsController.Creating = false;
    
    
    UITradeDetailViewController *DatesController = [self.storyboard instantiateViewControllerWithIdentifier:@"Dates"];
    DatesController.Creating = false;
    
    

    self.DetailControllers = @[controller,ItemsController,DatesController];
    
    
    
    dispatch_async( dispatch_get_main_queue(), ^{
        
    FakeDB* db = [FakeDB GetDBInstance];
   
    self.ActivityDetail = [db GetActivityDetail:self.ActivityDetail[@"id"]];
    
    ItemsController.ItemList = self.ActivityDetail[@"items"];
    DatesController.EntryList = self.ActivityDetail[@"tradeDates"];
    
    
    [ItemsController updateData];
    [DatesController updateData];
        
    });
    
    
    
    
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    int index = [self.DetailControllers indexOfObject:viewController];
    
    if(index<=0)return nil;
    
    index --;
    
    return self.DetailControllers[index];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    int index =  [self.DetailControllers indexOfObject:viewController];
    
    if(index>=[self.DetailControllers count]-1)return nil;
    
    index ++;
    
    return self.DetailControllers[index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.DetailControllers count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{

    return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
