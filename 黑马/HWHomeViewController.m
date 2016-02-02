//
//  HWHomeViewController.m
//  黑马
//
//  Created by van1988ch on 16/1/27.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWItemTool.h"
#include "UIView+UIViewExtentsion.h"
#import "HWDropdownMenu.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0  alpha:1.0];
#define HWColor(r , g , b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface HWHomeViewController ()

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem =  [HWItemTool itemWithTarget:self action:@selector(friendSeacher) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem =  [HWItemTool itemWithTarget:self action:@selector(friendSeacher) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
   // UIButton *titleButton = [[UIButton alloc] init];
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.width = 150;
    titleButton.height = 30;
    //titleButton.backgroundColor= RandomColor;
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //titleButton.imageView.backgroundColor =RandomColor;
    //titleButton.titleLabel.backgroundColor = RandomColor;
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
}

- (void)titleClick:(UIButton*)titleButton {
    HWDropdownMenu *dropMenu = [HWDropdownMenu menu];
    UITableViewController *tableview= [[UITableViewController alloc] init];
    tableview.view.height = 44*3;
    tableview.view.width = 200;
    dropMenu.contentController =tableview;
    [dropMenu showFrom:titleButton];
}

- (void)friendSeacher {
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
