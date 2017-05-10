//
//  BWPopViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWPopViewController.h"

#import <objc/runtime.h>

@interface BWPopViewController ()

@property (nonatomic, strong, readwrite) BWPopTransitionDelegate *transitionDelegate;

@end

@implementation BWPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTransitionRecognizer:)];
    
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender {/* 由子类实现 */}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    return [recognizer velocityInView:self.view].x > 0;
}

- (BWPopTransitionDelegate *)transitionDelegate {
    if (_transitionDelegate == nil)
        _transitionDelegate = [[BWPopTransitionDelegate alloc] init];
    
    return _transitionDelegate;
}

@end
