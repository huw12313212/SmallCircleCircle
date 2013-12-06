//
//  UIJoinActivityViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UIJoinActivityViewController.h"
#import "FakeDB.h"
#import "huwAppDelegate.h"
#import "UIItemAmountViewController.h"

@interface UIJoinActivityViewController ()
@property (weak, nonatomic) IBOutlet UITextView *DescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *WebButton;
@property (weak, nonatomic) IBOutlet UILabel *PhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *ExpireDate;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *Fee;
@property (weak, nonatomic) IBOutlet UILabel *Constraint;
@property (weak, nonatomic) IBOutlet UILabel *PS;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *JoinButton;

@property (strong,nonatomic)id <DBQueryInterface> Database;
@property (strong,nonatomic) NSDictionary* data;


@end

@implementation UIJoinActivityViewController

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
    if(self.Join)
    {
        [self.JoinButton setEnabled:YES];
        self.JoinButton.title = @"Join";
    }
    else
    {
        [self.JoinButton setEnabled:NO];
        self.JoinButton.title = @"";
    }
    
    [self.DescriptionLabel.layer  setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.25] CGColor]];
    [self.DescriptionLabel.layer setBorderWidth:1.0];
    self.DescriptionLabel.layer.cornerRadius = 5;
    self.DescriptionLabel.clipsToBounds = YES;
    self.Database = [FakeDB GetDBInstance];
    NSString* ActivityID = [huwAppDelegate getOpenId];
    [huwAppDelegate clearURL];
    self.data = [self.Database GetActivityDetail:ActivityID];
    
   // NSLog(@"%d",ActivityID);
    
    self.navigationItem.title = self.data[@"name"];
    
    self.DescriptionLabel.text = self.data[@"description"];
    
    
    [self.WebButton setTitle:self.data[@"url"] forState:UIControlStateNormal];
    
    
    self.PhoneNumber.text = self.data[@"phone"];
    self.ExpireDate.text = self.data[@"expireDate"];
    self.Location.text = self.data[@"location"];
    
    NSString* FeeDescription = [NSString stringWithFormat:@"%@$,%@",self.data[@"fee"][@"feeAmount"],self.data[@"fee"][@"feeStyle"]];
    
    self.Fee.text=FeeDescription;
    
    self.PS.text = self.data[@"PS"];
    
    
    NSString* constraint = [NSString stringWithFormat:@"%@%@",self.data[@"constraint"][@"type"],self.data[@"constraint"][@"amount"]];
    
    self.Constraint.text =constraint;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)urlClick:(id)sender {
    
    NSString* url = self.data[@"url"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"Next"])
    {
        UIItemAmountViewController *NextController = segue.destinationViewController;
        NextController.AcitivityDetail = self.data;
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)JoinClicked:(id)sender {
}
@end
