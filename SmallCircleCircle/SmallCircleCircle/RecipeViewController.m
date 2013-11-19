//
//  RecipeViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/19.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@property (nonatomic,strong)NSMutableArray* itemData;

@end

@implementation RecipeViewController


int myTotal;
int myItemNumber;
int allTotal;
int allItemNumber;

long fee;

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
    
    [self calculateAllData];
    myTotal = 0;
    myItemNumber = 0;
    fee = 0;

    self.itemData = [[NSMutableArray alloc]init];
    
    NSArray* itemList = self.activityDetail[@"items"];
    
    for(int i = 0 ; i < [itemList count];i++)
    {
        NSDictionary* item = itemList[i];
        
        long number = [self.buyEntry[@"buyList"][i] integerValue];
        
        long total = number * [item[@"price"] integerValue];
        
        if(number > 0)
        {
            NSDictionary* validateEntry = @{@"name":item[@"name"],@"price":item[@"price"],@"count": @(number),@"total":@(total)};
            
            myItemNumber += number;
            myTotal += total;
            
            [self.itemData addObject:validateEntry];
        }
    }
    
    
    long totalFee = [self.activityDetail[@"fee"][@"feeAmount"]integerValue];
    
    if([self.activityDetail[@"fee"][@"feeStyle"] isEqualToString:@"依數量比重平分"])
    {
        fee = totalFee * myItemNumber / allItemNumber;
    }
    else if([self.activityDetail[@"fee"][@"feeStyle"]isEqualToString:@"依金額比重平分"])
    {
        fee = totalFee * myTotal / allTotal;
    }
    
}


-(void)calculateAllData
{
    allTotal = 0;
    allItemNumber = 0;
    
    for(int i = 0 ; i < [self.buyList count] ; i ++)
    {
        NSDictionary* nowBuy = self.buyList[i];
        NSArray* countArray = nowBuy[@"buyList"];
        
        for(int j=0 ; j< [countArray count]; j ++)
        {
            NSDictionary* nowItemData = self.activityDetail[@"items"][j];
            NSNumber* data = countArray[j];
            
            allItemNumber += [data integerValue];
            
            allTotal += [nowItemData[@"price"] integerValue] * [data integerValue];
            
        }
    }
    
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if(section==0)
    {
        return 1;
    }
    else if(section == 1)
    {
        return [self.itemData count] + 2;
    }
    else if(section == 2)
    {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"info" forIndexPath:indexPath];
        
        UILabel* label = (UILabel*)[cell viewWithTag:1];
        UILabel* label2 = (UILabel*)[cell viewWithTag:2];

        
        if(indexPath.row==0)
        {
            label.text = self.buyEntry[@"name"];
            label2.text = self.buyEntry[@"phone"];
        }
   
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row < [self.itemData count])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
            
            NSDictionary* currentEntry  = self.itemData[indexPath.row];
            
            UILabel* name = (UILabel*)[cell viewWithTag:1];
            UILabel* price = (UILabel*)[cell viewWithTag:2];
            UILabel* total = (UILabel*)[cell viewWithTag:3];
            
            
            
            name.text = currentEntry[@"name"];
            price.text =[currentEntry[@"price"] stringValue];
            total.text =[NSString stringWithFormat:@"× %@ = %@" ,currentEntry[@"count"], currentEntry[@"total"]];
            
        }
        else if(indexPath.row == [self.itemData count])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
            
            UILabel* name = (UILabel*)[cell viewWithTag:1];
            UILabel* price = (UILabel*)[cell viewWithTag:2];
            UILabel* total = (UILabel*)[cell viewWithTag:3];
            
            
            
            name.text = @"運費";
            price.text =self.activityDetail[@"fee"][@"feeStyle"];
            total.text =[@(fee) stringValue];
        }
        else if(indexPath.row == [self.itemData count] + 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"total" forIndexPath:indexPath];
            
            UILabel* name = (UILabel*)[cell viewWithTag:1];
            
            name.text = [NSString stringWithFormat:@"Total %ld",fee+myTotal];
        }

        
    }
    else if(indexPath.section == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"status" forIndexPath:indexPath];
        
    }
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 44;
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row <[self.itemData count] + 1)
        {
            return 75;
        }
        else
        {
            return 44;
        }
        
        
    }
    else
    {
        return 44;
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"購買人";
    }
    else if(section == 1)
    {
        return @"明細";
    }
    else if(section == 2)
    {
        return @" ";
    }
    else
    {
        return @"undefined";
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
