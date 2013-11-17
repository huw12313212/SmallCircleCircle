//
//  UICheckViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/17.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UICheckViewController.h"

@interface UICheckViewController ()

@end

@implementation UICheckViewController

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    NSArray* allObject = self.AcitivityDetail[@"items"];
    
    return [allObject count]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray* allObject = self.AcitivityDetail[@"items"];
    NSString *CellIdentifier;
    UITableViewCell *cell;
    
    if(indexPath.row == allObject.count)
    {
        CellIdentifier = @"FeeCell";
         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        UILabel* FeeTypeLabel = (UILabel*)[cell viewWithTag:2];
        FeeTypeLabel.text = self.AcitivityDetail[@"fee"][@"feeStyle"];
        
        UILabel* moneyLabel = (UILabel*)[cell viewWithTag:3];
        
        
        double fee =[self GetFee];
        
        moneyLabel.text = [NSString stringWithFormat:@"<%.0lf",fee];
        
        
        
    }
    else if(indexPath.row == allObject.count+1)
    {
        CellIdentifier = @"TotalCell";
         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
          UILabel* TotalLabel = [cell viewWithTag:1];
        
        int result = 0;
        
        for(int i = 0 ; i< [allObject count];i++)
        {
            int nowPrice = [allObject[i][@"price"]integerValue];
            int number = [self.BuyAmountArray[i]integerValue];
            int total = nowPrice*number;
            
            result+=total;
        }
        
        result += [self GetFee];
        
        TotalLabel.text = [NSString stringWithFormat:@"Total : <%d",result];
        
    }
    else
    {
        CellIdentifier = @"ItemCell";
         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        UILabel* nameLabel = [cell viewWithTag:1];
        UILabel* priceLabel = [cell viewWithTag:2];
        UILabel* countLabel = [cell viewWithTag:3];
        
        int price = [allObject[indexPath.row][@"price"]integerValue];
        
        nameLabel.text = allObject[indexPath.row][@"name"];
        priceLabel.text =  [allObject[indexPath.row][@"price"]stringValue];
        
        int countToBuy = [self.BuyAmountArray[indexPath.row] integerValue];
        
        countLabel.text = [NSString stringWithFormat:@"× %d = %d",countToBuy,countToBuy*price];
        
    }
    
   
    
    
    
    return cell;
}

-(double)GetFee
{
    double fee = [self.AcitivityDetail[@"fee"][@"feeAmount"] doubleValue];
    
    #warning 先亂算.
    fee/= 10;
    
    
    return fee;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* allObject = self.AcitivityDetail[@"items"];
    if(indexPath.row == allObject.count)
    {

        return 75;
    }
    else if(indexPath.row == allObject.count+1)
    {

        return 35;
    }
    else
    {
        return 75;
    }

    
}
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
