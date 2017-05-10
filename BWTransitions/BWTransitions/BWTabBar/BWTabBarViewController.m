//
//  BWTabBarViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/8.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWTabBarViewController.h"

#import "BWTabBarTransitionDelegate.h"

#import "BWTab1ViewController.h"
#import "BWTab2ViewController.h"

@interface BWTabBarViewController ()

@property (nonatomic, strong) BWTabBarTransitionDelegate *transitionDelegate;

@end

@implementation BWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpdateChildViewController];

//    self.delegate = self.transitionDelegate;
    
    self.transitionDelegate.tabBarController = self;
    
    // 注意：如果把UITabBarController添加到ViewController作为
    //      子视图，则使用
    //      self.transitionDelegate.tabBarController = self.tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpdateChildViewController {
    
    
    UINavigationController *tab1Navigation = ({
        BWTab1ViewController *tabViewController = [[BWTab1ViewController alloc] init];
        tabViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab1"
                                                                    image:[self orignialImage:@"tabHomeIcon"]
                                                              selectedImage:[self orignialImage:@"tabHomeHIcon"]];
        
        [[UINavigationController alloc] initWithRootViewController:tabViewController];
    });
    
    UINavigationController *tab2Navigation = ({
        BWTab2ViewController *tabViewController = [[BWTab2ViewController alloc] init];
        tabViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab2"
                                                                        image:[self orignialImage:@"tabCourseIcon"]
                                                                selectedImage:[self orignialImage:@"tabCourseHIcon"]];
        
        
        [[UINavigationController alloc] initWithRootViewController:tabViewController];
    });
    
    
    
    self.viewControllers = @[ tab1Navigation, tab2Navigation ];
    
    UITabBar *tabBar = self.tabBar;
    tabBar.translucent = NO;
    tabBar.barStyle = UIBarStyleDefault;
    
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabTopLine"]];
    
}

- (UIImage *)orignialImage:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (BWTabBarTransitionDelegate *)transitionDelegate {
    if (_transitionDelegate == nil)
        _transitionDelegate = [[BWTabBarTransitionDelegate alloc] init];
    
    return _transitionDelegate;
}

@end
