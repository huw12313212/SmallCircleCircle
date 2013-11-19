//
//  TotalBuyTableViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/18.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "TotalBuyTableViewController.h"

@interface TotalBuyTableViewController ()

@property(nonatomic,strong)NSMutableArray* TotalSumArray;

@end



@implementation TotalBuyTableViewController

static TotalBuyTableViewController* _instance;
int totalMoney = 0;

+(TotalBuyTableViewController*)GetInstance
{
    return _instance;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    _instance = self;
    
    
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
 
    
    totalMoney = 0;
    
    NSArray* itemList = self.activityDetail[@"items"];
    
    self.TotalSumArray = [[NSMutableArray alloc]init];
    
    for(int i = 0 ;i< itemList.count;i++)
    {
        [self.TotalSumArray addObject:@(0)];
    }
    
    for(int i = 0 ;i< self.buyList.count;i++)
    {
        NSDictionary* currentBuy = self.buyList[i];
        
        NSArray* buyList = currentBuy[@"buyList"];
        
        for(int j = 0; j < buyList.count;j++)
        {
            self.TotalSumArray[j] =  @([self.TotalSumArray[j] integerValue] + [buyList[j] integerValue]);
        }
    }
    
    //NSLog(@"total count : %@", self.TotalSumArray);
    
    
    for(int i =0;i<itemList.count;i++)
    {
        totalMoney += [itemList[i][@"price"] integerValue] * [self.TotalSumArray[i] integerValue];
    }
    
    totalMoney += [self.activityDetail[@"fee"][@"feeAmount"] integerValue];
    
    
    [super viewDidLoad];

       [self.tableView setContentInset:UIEdgeInsetsMake(66,0,0,0)];
    //NSLog(@"hello");
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.TotalSumArray count] + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *CellIdentifier;
     UITableViewCell *cell ;
    

    if(indexPath.row < [self.TotalSumArray count])
    {
        CellIdentifier= @"item";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel *nameLabel = [cell viewWithTag:1];
        UILabel *priceLabel = [cell viewWithTag:2];
        UILabel *resultLabel = [cell viewWithTag:3];
        
        nameLabel.text = self.activityDetail[@"items"][indexPath.row][@"name"];
        priceLabel.text = [self.activityDetail[@"items"][indexPath.row][@"price"]stringValue];
        
        int count = [self.TotalSumArray[indexPath.row] integerValue];
        int price = [self.activityDetail[@"items"][indexPath.row][@"price"] integerValue];
       
        NSString* str = [NSString stringWithFormat:@"× %d = %d", count, count*price];
        
        resultLabel.text = str;
        
        
    }
    else if(indexPath.row == [self.TotalSumArray count])
    {
        CellIdentifier= @"fee";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel *fee = [cell viewWithTag:2];
        
        fee.text = [self.activityDetail[@"fee"][@"feeAmount"]stringValue];
        
    }
    else if(indexPath.row == [self.TotalSumArray count] + 1)
    {
        CellIdentifier= @"total";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel *total = [cell viewWithTag:1];
        
        total.text = [NSString stringWithFormat:@"Total %d", totalMoney];
    }
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allObject = self.activityDetail[@"items"];
    if(indexPath.row == allObject.count)
    {
        
        return 45;
    }
    else if(indexPath.row == allObject.count+1)
    {
        
        return 45;
    }
    else
    {
        return 75;
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
