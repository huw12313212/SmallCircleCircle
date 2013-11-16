//
//  UICreateActivityInfoViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UICreateActivityInfoViewController.h"
#import "FakeDB.h"
#import "DBQueryInterface.h"
#import <QuartzCore/QuartzCore.h>

@interface UICreateActivityInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ActivityName;
@property (weak, nonatomic) IBOutlet UITextView *Description;
@property (weak, nonatomic) IBOutlet UITextField *URL;
@property (weak, nonatomic) IBOutlet UITextField *Location;
@property (weak, nonatomic) IBOutlet UITextField *PS;

@property (weak, nonatomic) IBOutlet UITextField *ExpireDate;
@property (strong,nonatomic)id <DBQueryInterface> Database;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end

@implementation UICreateActivityInfoViewController
UIGestureRecognizer *tapper;

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        
        self.Database = [FakeDB GetDBInstance];

        //ScrollView set
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.Description.layer  setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.25] CGColor]];
    [self.Description.layer setBorderWidth:1.0];
    self.Description.layer.cornerRadius = 5;
    self.Description.clipsToBounds = YES;
    
    
    
    //Date Change
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [self.ExpireDate setInputView:datePicker];
    

    [datePicker addTarget:self
               action:@selector(datePickerValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    
    //Cancel Tapper
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    
    
    [self.ScrollView setScrollEnabled:YES];
    [self.ScrollView setContentSize:CGSizeMake(320,600)];
    [super viewDidLoad];
}

- (void)datePickerValueChanged:(id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSString *dateString;
    
    dateString = [NSDateFormatter localizedStringFromDate:[picker date]
                                                dateStyle:NSDateFormatterMediumStyle
                                                timeStyle:NSDateFormatterMediumStyle];
    
    [self.ExpireDate setText:dateString];
}


- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
