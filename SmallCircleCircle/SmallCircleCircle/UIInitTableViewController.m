//
//  UIInitTableViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UIInitTableViewController.h"
#import "DBQueryInterface.h"
#import "FakeDB.h"
#import "UIJoinActivityViewController.h"
#import "TabbarViewController.h"

@interface UIInitTableViewController ()

@property (strong,nonatomic)id <DBQueryInterface> Database;
@property (strong,nonatomic)NSArray* CreatedAcitivities;
@property (strong,nonatomic)NSArray* JoinedAcitivities;

@end

@implementation UIInitTableViewController


enum AcitivityType
{
    Created,
    Join,
    TypeCount,
};

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
<<<<<<< HEAD
        self.Database = [FakeDB GetDBInstance];
        self.CreatedAcitivities = [self.Database GetCreatedActivity : @"0"];
        self.JoinedAcitivities = [self.Database GetJoinedActivity : @"0"];
=======
        
        self.Database = [FakeDB GetDBInstance];
        self.CreatedAcitivities = [self.Database GetCreatedActivity : 0];
        self.JoinedAcitivities = [self.Database GetJoinedActivity : 0];
>>>>>>> be54ca681ed663993d1d1a80c1501f8d84adc284
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Add:)];

    }
    return self;
}

-(IBAction)Add:(id)sender
{
    [self performSegueWithIdentifier:@"CreateActivity" sender:self];
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];

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
    return TypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 0;
    
    switch (section)
    {
        case Created:
            return [self.CreatedAcitivities count];
            break;
        case Join:
            return [self.JoinedAcitivities count];
            break;
        default:
            return 0;
            break;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* target;
    NSString* statusStr;
    NSString* cellType;
    
    switch (indexPath.section)
    {
        case Created:
            
            target = self.CreatedAcitivities[indexPath.row];
           
            break;
        case Join:

            target = self.JoinedAcitivities[indexPath.row];
            break;
        default:

            target = @{@"id":@(9999),@"name":@"undifined",@"status":@(ASFailed)};
            cellType = @"SuccessActivity";
            break;
    }
    
    
    NSNumber *statusNumber = target[@"status"];
    
    switch ([statusNumber intValue]) {
        case ASRecruting:
            statusStr = @"招募中";
             cellType = @"OtherActivity";
            break;
        case ASSuccess:
            statusStr = @"成功";
            
            
            if(indexPath.section == Created)
            {
                cellType = @"SuccessActivity";
            }
            else if(indexPath.section == Join)
            {
                cellType = @"JoinedSuccessActivity";
            }
            
            break;
        case ASFailed:
            statusStr = @"流團";
             cellType = @"OtherActivity";
            break;
        default:
            break;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType forIndexPath:indexPath];
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
    UILabel* statusLabel = (UILabel*)[cell viewWithTag:2];
    
    nameLabel.text = target[@"name"];

    statusLabel.text = statusStr;

    
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case Created:
            return @"我建立的";
            break;
        case Join:
            return @"我參加的";
            break;
        default:
            return @"其他";
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"hostDetail"])
    {
        TabbarViewController *viewController = segue.destinationViewController;
        
        NSIndexPath * path = [self.tableView indexPathForCell:sender];
        NSString* ActivityID = self.CreatedAcitivities[path.row][@"id"];
<<<<<<< HEAD
        NSString* BuyID = self.JoinedAcitivities[path.row][@"id"];
        
        NSDictionary* activityDetail = [self.Database GetActivityDetail:ActivityID];
        NSArray* buyList = [self.Database GetBuyList:BuyID];
=======
        
        
        NSDictionary* activityDetail = [self.Database GetActivityDetail:ActivityID];
        NSArray* buyList = [self.Database GetBuyList:ActivityID];
>>>>>>> be54ca681ed663993d1d1a80c1501f8d84adc284
        
        viewController.activityDetail = activityDetail;
        viewController.buyList = buyList;
    }
}



@end
