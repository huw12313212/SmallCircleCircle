//
//  UIContactViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/18.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UIContactViewController.h"
#import "FakeDB.h"

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
        [self UploadData];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    [self.DataBase JoinActivity:@"0" :self.ActivityDetail[@"id"]:dictionary];
    
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
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
