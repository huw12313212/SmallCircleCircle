//
//  JoinedBuyDetailViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/19.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "JoinedBuyDetailViewController.h"

@interface JoinedBuyDetailViewController ()

@property (nonatomic,strong)NSDictionary * locationDictionary;
@property (nonatomic,strong)NSArray* locationArray;
@property (nonatomic,strong)NSArray* locationNameArray;


@end

@implementation JoinedBuyDetailViewController

static JoinedBuyDetailViewController* _instance;

+(JoinedBuyDetailViewController*)GetInstance
{
    return _instance;
}

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    _instance = self;
    
    NSLog(@"init with coder");
    
    if (self) {
        
    }
    return self;
}

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
    
    self.locationDictionary = [[NSMutableDictionary alloc] init];
    
//   // NSLog(@"offset %lf",self.tableView.contentOffset.y);
//    [self.tableView setContentOffset:CGPointMake(0, -100)];
//    
//    NSLog(@"offset %lf",self.tableView.contentOffset.y);
    for(int i = 0;i<self.buyList.count;i++)
    {
        NSDictionary* nowBuy = self.buyList[i];
        
        NSString* locationAndDate = [NSString stringWithFormat:@"%@ %@",nowBuy[@"location"],nowBuy[@"date"]];
        
        NSMutableArray* array = self.locationDictionary[locationAndDate];
        
        if(array == nil)
        {
            array = [[NSMutableArray alloc]init];
            
            [self.locationDictionary setValue:array forKey:(locationAndDate)];
        }
        
        [array addObject:nowBuy];
    }
    
   // CGRect rec = self.tableView.frame;
    
    
   [self.tableView setContentInset:UIEdgeInsetsMake(66,0,0,0)];
    //NSLog(@"buyList : %@",self.buyList);
      //  NSLog(@"activity : %@",self.activityDetail);
    
    self.locationArray = [self.locationDictionary allValues];
    self.locationNameArray = [self.locationDictionary allKeys];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.locationArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    NSArray* currentArray = self.locationArray[section];
    
    
    return currentArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return  self.locationNameArray[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
    UILabel* statusLabel = (UILabel*)[cell viewWithTag:2];
    
    
    NSArray * currentArray = self.locationArray[indexPath.section];
    NSDictionary * data = currentArray[indexPath.row];
    
    
    nameLabel.text = data[@"name"];
    
    if([data[@"finished"] boolValue] == YES)
    {
        statusLabel.text = @"已完成";
    }
    else
    {
        statusLabel.text = @"未交貨";
    }
    
    // Configure the cell...
    
    return cell;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
