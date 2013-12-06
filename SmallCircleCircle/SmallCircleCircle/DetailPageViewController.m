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

- (void)viewDidLoad
{
    //self sett = UIPageViewControllerTransitionStyleScroll;
    
    //UIButton* ExitButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
   // ExitButton.titleLabel.text = @"Exit";
  //  [self.view addSubview:ExitButton];
    
    
    FakeDB* db = [FakeDB GetDBInstance];
    [huwAppDelegate setOpenId:self.ActivityDetail[@"id"]];
    self.ActivityDetail = [db GetActivityDetail:self.ActivityDetail[@"id"]];
    self.dataSource = self;

    
    UIJoinActivityViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetail"];
    [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    
   
    UIItemViewController *ItemsController = [self.storyboard instantiateViewControllerWithIdentifier:@"Items"];
    ItemsController.Creating = false;
    ItemsController.ItemList = self.ActivityDetail[@"items"];
    
    UITradeDetailViewController *DatesController = [self.storyboard instantiateViewControllerWithIdentifier:@"Dates"];
    DatesController.Creating = false;
    DatesController.EntryList = self.ActivityDetail[@"tradeDates"];
    
    
    [ItemsController updateData];
    [DatesController updateData];
    
    self.DetailControllers = @[controller,ItemsController,DatesController];
    
    
    
    
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
