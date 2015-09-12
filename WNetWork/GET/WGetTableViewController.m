//
//  WGetTableViewController.m
//  WNetWork
//
//  Created by HoTia on 15/9/6.
//  Copyright (c) 2015年 will. All rights reserved.
//

#import "WGetTableViewController.h"
#import "WGetViewController.h"

@interface WGetTableViewController ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation WGetTableViewController

#pragma mark datas

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


#pragma mark View

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *oj_1 = NSLocalizedString(@"wGetTableViewController_oj_1", @"");
    [self.datas addObject:oj_1];
    NSString *oj_2 = NSLocalizedString(@"wGetTableViewController_oj_2", @"");
    [self.datas addObject:oj_2];
    NSString *oj_3 = NSLocalizedString(@"wGetTableViewController_oj_3", @"");
    [self.datas addObject:oj_3];
    NSString *oj_4 = NSLocalizedString(@"wGetTableViewController_oj_4", @"");
    [self.datas addObject:oj_4];
    NSString *oj_5 = NSLocalizedString(@"wGetTableViewController_oj_5", @"");
    [self.datas addObject:oj_5];
    NSString *oj_6 = NSLocalizedString(@"wGetTableViewController_oj_6", @"");
    [self.datas addObject:oj_6];
    
    
    
    
    self.title = NSLocalizedString(@"wGetTableViewController_title", @"");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"getCell"];
    }
    [cell.textLabel setText:self.datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGetViewController *viewController = [[WGetViewController alloc] init];
    viewController.title = self.datas[indexPath.row];
    viewController.row = indexPath.row;
    [self.navigationController pushViewController:viewController animated:YES];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


