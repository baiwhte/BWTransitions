//
//  BWPopSecondViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWPopSecondViewController.h"

@interface BWPopSecondViewController ()

@end

@implementation BWPopSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        
        BWPopTransitionDelegate *transitionDelegate = self.transitionDelegate;
        transitionDelegate.gestureRecognizer = sender;
        self.navigationController.delegate = self.transitionDelegate;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)popAction:(id)sender {
    
    self.navigationController.delegate = self.transitionDelegate;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
