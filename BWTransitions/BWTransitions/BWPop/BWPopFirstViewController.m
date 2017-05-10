//
//  BWPopFirstViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWPopFirstViewController.h"

#import "BWPopTransitionDelegate.h"
#import "BWPopSecondViewController.h"

@interface BWPopFirstViewController ()

@end

@implementation BWPopFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"First";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushAction:(id)sender {
    BWPopSecondViewController *viewController = [[BWPopSecondViewController alloc] init];
     [self.navigationController pushViewController:viewController animated:YES];
}

- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        BWPopSecondViewController *viewController = [[BWPopSecondViewController alloc] init];
        BWPopTransitionDelegate *transitionDelegate = self.transitionDelegate;
        transitionDelegate.gestureRecognizer = sender;
        self.navigationController.delegate = self.transitionDelegate;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}



@end
