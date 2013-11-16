//
//  UIItemViewController.m
//  SmallCircleCircle
//
//  Created by 王 瀚宇 on 2013/11/16.
//  Copyright (c) 2013年 王 瀚宇. All rights reserved.
//

#import "UIItemViewController.h"
#import "UINewItemViewController.h"

@interface UIItemViewController ()

@property (strong,nonatomic)NSMutableArray* ItemList;

@end

@implementation UIItemViewController

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
    
    if(self.ItemList == nil)
    {
        self.ItemList = [[NSMutableArray alloc]init];
    }

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
    int data =[self.ItemList count];
    data+=1;
    
    //NSLog(@"length %d",[self.ItemList count]);
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return data;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *CellIdentifier;
    if(indexPath.row == [self.ItemList count])
    {
    CellIdentifier = @"New";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    }
    else
    {
    CellIdentifier = @"Item";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        UILabel* nameLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* priceLabel = (UILabel*)[cell viewWithTag:2];
        
        nameLabel.text = self.ItemList[indexPath.row][@"name"];
        priceLabel.text = self.ItemList[indexPath.row][@"price"];
    }
    
    return cell;
}

-(void)updateData
{
    [self.tableView reloadData];
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"New"])
    {
        UINewItemViewController* newItemView = segue.destinationViewController;
        newItemView.Items = self.ItemList;
        newItemView.parentView = self;
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
