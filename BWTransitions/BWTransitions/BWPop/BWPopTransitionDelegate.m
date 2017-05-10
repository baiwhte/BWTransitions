//
//  BWPopTransitionDelegate.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWPopTransitionDelegate.h"

#import "BWPopAnimatedTransition.h"
#import "BWPopInteractiveTransition.h"

@interface BWPopTransitionDelegate ()

@property (nonatomic, readwrite) UINavigationControllerOperation targetOperation;

@end

@implementation BWPopTransitionDelegate

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (self.gestureRecognizer)
        return [[BWPopInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer
                                                        operationForDragging:self.targetOperation];
    else
        return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  {
    self.targetOperation = operation;
    if (self.gestureRecognizer)
        return [[BWPopAnimatedTransition alloc] initWithTargetOperation:operation];
    else
        return nil;
}

@end
