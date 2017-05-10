//
//  BWViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/8.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWMainViewController.h"

#import "BWModalFirstViewController.h"
#import "BWPopFirstViewController.h"
#import "BWTabBarViewController.h"

@interface BWMainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation BWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"main";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UITableViewDelegate
//
//#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return   [self.array count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"UITableViewCellIdentifier";
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *transitions = self.array[indexPath.section];
    cell.textLabel.text = transitions;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        BWModalFirstViewController *viewController = [[BWModalFirstViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    } else if (indexPath.section ==  1) {
        BWPopFirstViewController *viewController = [[BWPopFirstViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        BWTabBarViewController *viewController = [[BWTabBarViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}


- (NSArray *)array {
    return @[
             @"Modal - Present/Dismiss",
             @"Navigation - Push/Pop",
             @"TabBar"
             ];
}
@end
