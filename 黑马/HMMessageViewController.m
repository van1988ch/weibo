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
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)composeMsg
{
    NSLog(@"COMPOSEmsg");
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
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
    NSLog(@"%@" , self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
}

@end
