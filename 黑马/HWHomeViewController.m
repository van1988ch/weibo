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
#import "AFNetworking.h"
#import "HWAccountTool.h"
#import "HWAccount.h"
#import "HWTitleButton.h"
#import "UIImageView+WebCache.h"
#import "HWUser.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "HWLoadMoreFooter.h"


#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0  alpha:1.0];
#define HWColor(r , g , b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]



@interface HWHomeViewController ()
@property (nonatomic , strong) NSMutableArray * statuses;
@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [self loadAccount];
    //[self loadNewStaus];
    [self setupDownRefresh];
    [self setupUpRefresh];
}


-(NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses = [NSMutableArray array];
    }
    return _statuses;
}

-(void)setupUpRefresh
{
    self.tableView.tableFooterView = [HWLoadMoreFooter footer];
}

-(void)setupDownRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    [control beginRefreshing];
    [self refreshStateChange:control];
}

-(void)refreshStateChange:(UIRefreshControl*)control
{
    NSLog(@"refresh");
    AFHTTPRequestOperationManager *magr = [AFHTTPRequestOperationManager manager];
    HWAccount *account = [HWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    HWStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    
    [magr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation , id responseObject){
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in dictArray) {
            HWStatus * status = [HWStatus statusWirhDict:dict];
            [arr addObject:status];
        }
        NSRange range = NSMakeRange(0, arr.count);
        NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:arr atIndexes:set];
        
        [self.tableView reloadData];
        [control endRefreshing];
        
        [self showNewStatusCount:arr.count];
        
    } failure:^(AFHTTPRequestOperation *operation , NSError *error)
     {
         NSLog(@"%@" , error);
         [control endRefreshing];
     }];
}

-(void)showNewStatusCount:(int)count
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    if (count == 0) {
        label.text = [NSString stringWithFormat:@"没有微博，稍后再试"];
    }else
    {
        label.text = [NSString stringWithFormat:@"共有%d条微博" , count];
    }
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.y = 64-label.height;
    label.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.y += label.height;
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:1.0 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.y -= label.height;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

-(void)loadNewStaus
{
    AFHTTPRequestOperationManager *magr = [AFHTTPRequestOperationManager manager];
    HWAccount *account = [HWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    [magr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation , id responseObject){
        NSArray *dictArray = responseObject[@"statuses"];
        for (NSDictionary *dict in dictArray) {
            HWStatus * status = [HWStatus statusWirhDict:dict];
            [self.statuses addObject:status];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation , NSError *error)
     {
         NSLog(@"%@" , error);
     }];
}

- (void)loadAccount
{
    AFHTTPRequestOperationManager *magr = [AFHTTPRequestOperationManager manager];
    HWAccount *account = [HWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [magr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation , id responseObject){
        //NSLog(@"%@" , responseObject);
        HWTitleButton * titleButton = (HWTitleButton *)self.navigationItem.titleView;
        //NSString * name = responseObject[@"name"];
        HWUser *user = [HWUser userWirhDict:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        account.name = user.name;
        [HWAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation , NSError *error)
     {
         NSLog(@"%@" , error);
     }];
}

- (void)loadNav
{
    self.navigationItem.leftBarButtonItem =  [HWItemTool itemWithTarget:self action:@selector(friendSeacher) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem =  [HWItemTool itemWithTarget:self action:@selector(friendSeacher) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    HWTitleButton * titleButton = [[HWTitleButton alloc] init];
    NSString *account = [HWAccountTool account].name;
    [titleButton setTitle:account?account:@"首页" forState:UIControlStateNormal];

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    
    static NSString *id = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
    }
    
    
    HWStatus *status =  self.statuses[indexPath.row];
    HWUser *user = status.user;
    
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text =status.text;
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placehoder];
    return cell;
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
