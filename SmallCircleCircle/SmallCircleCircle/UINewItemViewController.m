//
//  UINewItemViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UINewItemViewController.h"
#import "UIItemViewController.h"

@interface UINewItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Price;

@end

@implementation UINewItemViewController

- (IBAction)Comfirm:(id)sender {
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc]init];
    
    
    
    if([self.Name.text length]<=1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"請輸入商品名稱" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    
    NSString* RegNumber = @"[0-9]*";
    NSPredicate* RegNumberTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", RegNumber];
    
    if(![RegNumberTest evaluateWithObject:self.Price.text]||[self.Price.text length]<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"資料錯誤" message:@"價格不符合格式" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
        
        return;
    }
  
    
    
    [dictionary setObject:self.Name.text forKey:@"name"];
    [dictionary setObject:self.Price.text forKey:@"price"];
    
    UIItemViewController *table = (UIItemViewController *)self.parentView;
    
    [self.Items addObject:dictionary];
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
