//
//  UINewTradeDetailViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UINewTradeDetailViewController.h"
#import "UITradeDetailViewController.h"

@interface UINewTradeDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Location;
@property (weak, nonatomic) IBOutlet UIDatePicker *Date;

@end

@implementation UINewTradeDetailViewController


- (IBAction)Confirm:(id)sender {
    
    if([self.Location.text length]<=1)
    {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"未輸入地點" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
        return;
    }
    
    
    
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc]init];
    
    NSString *dateString;
    
    dateString = [NSDateFormatter localizedStringFromDate:[self.Date date]
                                                dateStyle:NSDateFormatterMediumStyle
                                                timeStyle:NSDateFormatterMediumStyle];
    
    
    [dictionary setObject:dateString forKey:@"date"];
    [dictionary setObject:self.Location.text forKey:@"location"];
    
    UITradeDetailViewController *table = (UITradeDetailViewController *)self.parentView;
    
    [self.Entries addObject:dictionary];
    [self dismissModalViewControllerAnimated:YES];
    
    [table updateData];
}

- (IBAction)Cancel:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
