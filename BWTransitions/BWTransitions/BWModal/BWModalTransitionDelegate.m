//
//  BWTransitionDelegate.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/9.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWModalTransitionDelegate.h"

#import "BWModalAnimatedTransition.h"
#import "BWModalInteractiveTransition.h"

@implementation BWModalTransitionDelegate


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[BWModalAnimatedTransition alloc] initWithTargetEdge:self.targetEdge];
}



- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[BWModalAnimatedTransition alloc] initWithTargetEdge:self.targetEdge];
}


//  先调用 -animationControllerForPresentedController:presentingController:sourceController: 方法
//  然后调用该方法
//
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer)
        return [[BWModalInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}



//  If a <UIViewControllerAnimatedTransitioning> was returned from
//  -animationControllerForDismissedController:,
//  先调用-animationControllerForDismissedController: 方法
//  然后调用该方法
//
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer)
        return [[BWModalInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}

@end
