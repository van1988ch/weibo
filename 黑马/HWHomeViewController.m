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
    [self loadNewStaus];
    
}


-(NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses = [NSMutableArray array];
    }
    return _statuses;
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
