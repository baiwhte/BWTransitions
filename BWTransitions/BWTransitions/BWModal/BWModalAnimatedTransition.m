//
//  BWAnimatedTransition.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/9.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWModalAnimatedTransition.h"

@implementation BWModalAnimatedTransition

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
    
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    
    // If this is a presentation, toViewController corresponds to the presented
    // view controller and its presentingViewController will be
    // fromViewController.  Otherwise, this is a dismissal.
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];

    CGVector offset = CGVectorMake(0, 0);
    if (self.targetEdge == UIRectEdgeTop)
        offset = CGVectorMake(0.f, 1.f);
    else if (self.targetEdge == UIRectEdgeBottom)
        offset = CGVectorMake(0.f, -1.f);
    else if (self.targetEdge == UIRectEdgeLeft)
        offset = CGVectorMake(1.f, 0.f);
    else if (self.targetEdge == UIRectEdgeRight)
        offset = CGVectorMake(-1.f, 0.f);
    else
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    if (isPresenting) {

        fromView.frame = fromFrame;
        UIView *fromSnapshot = [fromView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:fromSnapshot];
        

        toView.frame = toFrame;
        UIView * toSnapshot = [toView snapshotViewAfterScreenUpdates:YES];
        toSnapshot.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
                                   toFrame.size.height * offset.dy * -1);
        [containerView addSubview:toSnapshot];

        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{

            toSnapshot.frame = toFrame;
            toView.frame = toFrame;
            
        } completion:^(BOOL finished) {

            [fromSnapshot removeFromSuperview];
            [toSnapshot removeFromSuperview];
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            
            if (wasCancelled)
                [toView removeFromSuperview];
            else
                [containerView addSubview:toView];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
        
    } else {
        
        
        toView.frame = toFrame;
        UIView * toSnapshot = [toView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:toSnapshot];

        fromView.frame = fromFrame;
        UIView * fromSnapshot = [fromView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:fromSnapshot];
        
        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            fromSnapshot.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(toView.frame), 0);
            
        } completion:^(BOOL finished) {

            [toSnapshot removeFromSuperview];
            
            [fromSnapshot removeFromSuperview];
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            
            if (wasCancelled)
                [toView removeFromSuperview];
            else
                [containerView addSubview:toView];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }
}

@end
