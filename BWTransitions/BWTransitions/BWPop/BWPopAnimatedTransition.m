//
//  BWPopAnimatedTransition.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWPopAnimatedTransition.h"

@implementation BWPopAnimatedTransition

- (instancetype)initWithTargetOperation:(UINavigationControllerOperation)targetOperation
{
    self = [self init];
    if (self) {
        _targetOperation = targetOperation;
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
    
    
    
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    if (_targetOperation == UINavigationControllerOperationPush) {

        UIView *fromSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:fromSnapshot];
        fromViewController.view.hidden = YES;
        
        toViewController.view.frame = CGRectOffset(toFrame, CGRectGetWidth(toFrame), 0);
        [containerView addSubview:toViewController.view];
        
        [UIView animateWithDuration:transitionDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             fromSnapshot.alpha = 0.0;
                             fromSnapshot.frame = CGRectInset(fromViewController.view.frame, 20, 20);
                             toViewController.view.frame = CGRectOffset(toViewController.view.frame, -CGRectGetWidth(toViewController.view.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             fromViewController.view.hidden = NO;
                             [fromSnapshot removeFromSuperview];
                             BOOL wasCancelled = [transitionContext transitionWasCancelled];
                             if (wasCancelled)
                                 [toViewController.view removeFromSuperview];
                             [transitionContext completeTransition:!wasCancelled];
                         }];
        
        
    } else {
        

        UIView *fromSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:YES];
        [fromViewController.view addSubview:fromSnapshot];

//        fromViewController.navigationController.navigationBar.hidden = YES;
//        fromViewController.tabBarController.tabBar.hidden = YES;
        
        UIView * toSnapshot = [toViewController.view snapshotViewAfterScreenUpdates:YES];
        toSnapshot.alpha = 0.5;
//        toSnapshot.transform = CGAffineTransformMakeScale(0.95, 0.95);
//        CGAffineTransformMakeTranslation(CGRectGetWidth(toFrame), 0);
        UIView *toViewWrapperView = [[UIView alloc] initWithFrame:[transitionContext containerView].bounds];
        [toViewWrapperView addSubview:toViewController.view];
        
        toViewWrapperView.hidden = YES;
        
        [containerView addSubview:toViewWrapperView];
        [containerView addSubview:toSnapshot];
        [containerView bringSubviewToFront:fromViewController.view];
        
        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            fromViewController.view.frame = CGRectOffset(fromFrame, CGRectGetWidth(fromFrame), 0);
            toSnapshot.alpha = 1.0;
            toSnapshot.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            toViewController.navigationController.navigationBar.hidden = NO;
//            toViewController.tabBarController.tabBar.hidden = tabBarHidden;
            
            [fromSnapshot removeFromSuperview];
            [toSnapshot removeFromSuperview];
            
            [toViewWrapperView removeFromSuperview];
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            
            if (!wasCancelled)
                {
                for (UIView *subview in toViewWrapperView.subviews) {
                    [containerView addSubview:subview];
                }
            }
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }
}


@end
