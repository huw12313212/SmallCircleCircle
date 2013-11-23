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
