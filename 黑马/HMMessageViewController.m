//
//  HMMessageViewController.m
//  黑马
//
//  Created by van1988ch on 16/1/27.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HMMessageViewController.h"
#import "HWTest1ViewController.h"

@interface HMMessageViewController ()

@end

@implementation HMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%d", indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    HWTest1ViewController *test1 = [[HWTest1ViewController alloc] init];
    test1.title = @"测试1控制器";
    test1.hidesBottomBarWhenPushed = YES;
    NSLog(@"%@" , self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
}

@end
