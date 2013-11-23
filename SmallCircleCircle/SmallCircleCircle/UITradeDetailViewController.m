//
//  UITradeDetailViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UITradeDetailViewController.h"
#import "UINewTradeDetailViewController.h"
#import "FakeDB.h"
#import "UICompleteViewController.h"
@interface UITradeDetailViewController ()

@property (strong,nonatomic)NSMutableArray* EntryList;
@property (strong,nonatomic)NSObject<DBQueryInterface> *Database;

@end

@implementation UITradeDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if(self.EntryList==nil)
    {
        self.EntryList = [[NSMutableArray alloc]init];
    }
    
    self.Database = [FakeDB GetDBInstance];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int data =[self.EntryList count];
    data+=1;
    return data;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.EntryList count])
    {
        return 44;
    }
    else
    {
        return 70;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *CellIdentifier;
    if(indexPath.row == [self.EntryList count])
    {
        CellIdentifier = @"New";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    }
    else
    {
        CellIdentifier = @"Entry";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel* locationLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* timeLabel = (UILabel*)[cell viewWithTag:2];
        
        locationLabel.text = self.EntryList[indexPath.row][@"location"];
        timeLabel.text = self.EntryList[indexPath.row][@"date"];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"New"])
    {
        UINewTradeDetailViewController* newItemView = segue.destinationViewController;
        newItemView.Entries = self.EntryList;
        newItemView.parentView = self;
    }
    else if([segue.identifier  isEqual: @"Next"])
    {
        [self.dictionary setObject:self.EntryList forKey:@"tradeDates"];
        [self.Database CreateActivity:@"0" :self.dictionary];
        
        UICompleteViewController* controller = segue.destinationViewController;
        
        controller.share = false;
        
         // NSLog(@"%@",self.dictionary);
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)updateData
{
    
    
    [self.tableView reloadData];
}



@end
