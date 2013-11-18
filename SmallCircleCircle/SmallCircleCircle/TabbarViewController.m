//
//  TabbarViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/18.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "TabbarViewController.h"
#import "TotalBuyTableViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

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
    
        //NSLog(@"hello3 %@",self.buyList);

            TotalBuyTableViewController* totalBuy = [TotalBuyTableViewController GetInstance];
    
            totalBuy.activityDetail = self.activityDetail;
            totalBuy.buyList = self.buyList;
            

    
    //self.tabBarController.t
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
