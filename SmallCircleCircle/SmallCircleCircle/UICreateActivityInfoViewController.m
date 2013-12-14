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
#import "UIItemViewController.h"

@interface UICreateActivityInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ActivityName;
@property (weak, nonatomic) IBOutlet UITextView *Description;
@property (weak, nonatomic) IBOutlet UITextField *URL;
@property (weak, nonatomic) IBOutlet UITextField *Location;
@property (weak, nonatomic) IBOutlet UITextField *PS;

@property (weak, nonatomic) IBOutlet UITextField *ExpireDate;
@property (strong,nonatomic)id <DBQueryInterface> Database;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *Constraint;
@property (weak, nonatomic) IBOutlet UITextField *ConstraintNumber;
@property (weak, nonatomic) IBOutlet UITextField *Fee;

@end

@implementation UICreateActivityInfoViewController
UIGestureRecognizer *tapper;


- (IBAction)ConstraintClicked:(id)sender {
    
    if([self.Constraint.titleLabel.text isEqual:@("總數量大於")])
    {
        [self.Constraint setTitle:@"總金額大於" forState:UIControlStateNormal];
    }
    else
    {
        [self.Constraint setTitle:@"總數量大於" forState:UIControlStateNormal];
    }
}


- (IBAction)ButtonClicked:(UIBarButtonItem *)sender
{
    //NSLog(@"test");
    
    if([self isValidate])
    {
        [self performSegueWithIdentifier:@"Next" sender:sender];
    }
}

-(bool)isValidate
{

    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    
    NSString* phoneRegEx= @"^\\(?(\\d{2})\\)?[\\s\\-]?(\\d{4})\\-?(\\d{4})$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    
    NSString* RegNumber = @"[0-9]*";
    NSPredicate* RegNumberTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", RegNumber];
    
    if([self.ActivityName.text length]<=1)
    {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"活動名稱不可為空白" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        
        return NO;
    }
    else if([self.Description.text length]<=1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"簡介不可為空白" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(![urlTest evaluateWithObject:self.URL.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"請輸入合法網址" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(![phoneTest evaluateWithObject: self.phoneNumber.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"電話格式錯誤" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(![phoneTest evaluateWithObject: self.phoneNumber.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"電話格式錯誤" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(![RegNumberTest evaluateWithObject :self.ConstraintNumber.text]||[self.ConstraintNumber.text length]<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"請輸入出團條件" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else if(![RegNumberTest evaluateWithObject :self.Fee.text]||[self.Fee.text length]<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"請輸入預估運費" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        
        self.Database = [FakeDB GetDBInstance];

        //ScrollView set
        
        //self.navigationController.navigationItem.rightBarButtonItem set
        
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"Next"])
    {
        UIItemViewController *itemView= segue.destinationViewController;
        
        itemView.Creating = true;
        
        if(self.dictionary == nil)
        {
            self.dictionary = [[NSMutableDictionary alloc]init];
        }
        
        [self.dictionary setObject:self.ActivityName.text forKey:@"name"];
        [self.dictionary setObject:self.Description.text forKey:@"description"];
        [self.dictionary setObject:self.URL.text forKey:@"url"];
        [self.dictionary setObject:self.Location.text forKey:@"location"];
        [self.dictionary setObject:self.PS.text forKey:@"PS"];
        [self.dictionary setObject:self.ExpireDate.text forKey:@"expireDate"];
        [self.dictionary setObject:self.phoneNumber.text forKey:@"phone"];
        
        
        {
        NSMutableDictionary* constraint = [[NSMutableDictionary alloc]init];
        
        [constraint setObject:self.Constraint.titleLabel.text forKey:@"type"];
        [constraint setObject: self.ConstraintNumber.text forKey:@"amount"];
            
        [self.dictionary setObject:constraint forKey:@"constraint"];
        }
        
        
        {
            NSMutableDictionary* fee = [[NSMutableDictionary alloc]init];
            
            [fee setObject:self.Fee.text forKey:@"feeAmount"];
            
            NSString* feeStyle;
            
            if([self.Constraint.titleLabel.text isEqual:@("總數量大於")])
            {
               feeStyle = @"依數量比重平分";
            }
            else
            {
               feeStyle = @"依金額比重平分";
            }
            
            [fee setObject: feeStyle forKey:@"feeStyle"];
            
            [self.dictionary setObject:fee forKey:@"fee"];
        }
        
        itemView.dictionary = self.dictionary;
        
        //NSLog(@"%@",self.dictionary);
    }
}


- (void)viewDidLoad
{
    
    
    
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
    [self.ScrollView setContentSize:CGSizeMake(320,800)];
    
    [super viewDidLoad];

}

- (void)datePickerValueChanged:(id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSString *dateString;
    

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

    
    //dateString = [NSDateFormatter localizedStringFromDate:[picker date]
                                               // dateStyle:NSDateFormatterMediumStyle
                                               // timeStyle:NSDateFormatterMediumStyle];
     dateString = [dateFormatter stringFromDate:[picker date]];
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
