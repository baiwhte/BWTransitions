//
//  BWTabBarAnimatedTransition.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWTabBarAnimatedTransition.h"

@implementation BWTabBarAnimatedTransition

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge
{
    self = [self init];
    if (self) {
        _targetEdge = targetEdge;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //iOS8 以下使用
    // UIView *fromView = fromViewController.view;
    // UIView *toView = toViewController.view;
    
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    
    CGVector offset;
    if (self.targetEdge == UIRectEdgeLeft)
        offset = CGVectorMake(-1.f, 0.f);
    else if (self.targetEdge == UIRectEdgeRight)
        offset = CGVectorMake(1.f, 0.f);
    else
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeLeft, or UIRectEdgeRight.");
    
    fromView.frame = fromFrame;
    
    UIView * fromSnapshot = [fromView snapshotViewAfterScreenUpdates:YES];
    [containerView addSubview:fromSnapshot];
    
    toView.frame = toFrame;
    UIView * toSnapshot = [toView snapshotViewAfterScreenUpdates:YES];
    toSnapshot.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
                                toFrame.size.height * offset.dy * -1);
    
    // We are responsible for adding the incoming view to the containerView.
    [containerView addSubview:toSnapshot];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        fromSnapshot.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
                                      fromFrame.size.height * offset.dy);
        toSnapshot.frame = toFrame;
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [fromSnapshot removeFromSuperview];
        [toSnapshot removeFromSuperview];
        if (!wasCancelled) {
            [containerView addSubview:toView];
        }
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
