//
//  BWModalSecondViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/8.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWModalSecondViewController.h"


@interface BWModalSecondViewController ()

@end

@implementation BWModalSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {

        BWModalTransitionDelegate *transitionDelegate = self.transitioningDelegate;
        transitionDelegate.gestureRecognizer = sender;
        transitionDelegate.targetEdge = UIRectEdgeLeft;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
