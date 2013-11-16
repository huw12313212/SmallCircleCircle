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

- (void)viewDidLoad
{
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
