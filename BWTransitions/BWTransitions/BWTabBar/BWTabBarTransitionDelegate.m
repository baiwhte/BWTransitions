//
//  BWSlideTransitionDelegate.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/8.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWTabBarTransitionDelegate.h"
#import <objc/runtime.h>

#import "BWTabBarAnimatedTransition.h"
#import "BWTabBarInteractiveTransition.h"

const char * kBWTabBarControllerDelegateAssociationKey = "BWTabBarControllerDelegateAssociation";

@interface BWTabBarTransitionDelegate ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation BWTabBarTransitionDelegate

- (void)setTabBarController:(UITabBarController *)tabBarController
{
    if (tabBarController != _tabBarController) {
        // Remove all associations of this object from the old tab bar
        // controller.
        objc_setAssociatedObject(_tabBarController, kBWTabBarControllerDelegateAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [_tabBarController.view removeGestureRecognizer:self.panGestureRecognizer];
        if (_tabBarController.delegate == self) _tabBarController.delegate = nil;
        
        _tabBarController = tabBarController;
        
        _tabBarController.delegate = self;
        [_tabBarController.view addGestureRecognizer:self.panGestureRecognizer];
        // Associate this object with the new tab bar controller.  This ensures
        // that this object wil not be deallocated prior to the tab bar
        // controller being deallocated.
        objc_setAssociatedObject(_tabBarController, kBWTabBarControllerDelegateAssociationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark -
#pragma mark Gesture Recognizer

//| ----------------------------------------------------------------------------
//  Custom implementation of the getter for the panGestureRecognizer property.
//  Lazily creates the pan gesture recognizer for the tab bar controller.
//
- (UIPanGestureRecognizer*)panGestureRecognizer
{
    if (_panGestureRecognizer == nil)
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidPan:)];
    
    return _panGestureRecognizer;
}


//| ----------------------------------------------------------------------------
//! Action method for the panGestureRecognizer.
//
- (void)panGestureRecognizerDidPan:(UIPanGestureRecognizer*)sender
{
    // Do not attempt to begin an interactive transition if one is already
    // ongoing
    if (self.tabBarController.transitionCoordinator)
        return;
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged)
        [self beginInteractiveTransitionIfPossible:sender];
    
}


- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.tabBarController.view];
    
    if (translation.x > 0.f && self.tabBarController.selectedIndex > 0) {
        // 向右滑动, transition to the left view controller.
        self.tabBarController.selectedIndex--;
    } else if (translation.x < 0.f && self.tabBarController.selectedIndex + 1 < self.tabBarController.viewControllers.count) {
        // 向左滑动, transition to the right view controller.
        self.tabBarController.selectedIndex++;
    } else {
        // Don't reset the gesture recognizer if we skipped starting the
        // transition because we don't have a translation yet (and thus, could
        // not determine the transition direction).
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
            // There is not a view controller to transition to, force the
            // gesture recognizer to fail.
            sender.enabled = NO;
            sender.enabled = YES;
        }
    }
    
    // 如果在滑动期间改变了滑动方向而且手指没有离开屏幕，我们应该无缝改变转场动画，即取消
    // 原动画方向，按新的方向继续滑动，直至动画完成或取消
    [self.tabBarController.transitionCoordinator animateAlongsideTransition:NULL completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged)
            [self beginInteractiveTransitionIfPossible:sender];
    }];
}

#pragma mark -
#pragma mark UITabBarControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSAssert(tabBarController == self.tabBarController, @"%@ is not the tab bar controller currently associated with %@", tabBarController, self);
    NSArray *viewControllers = tabBarController.viewControllers;
    
    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {

        return [[BWTabBarAnimatedTransition alloc] initWithTargetEdge:UIRectEdgeLeft];
    } else {
        return [[BWTabBarAnimatedTransition alloc] initWithTargetEdge:UIRectEdgeRight];
    }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    NSAssert(tabBarController == self.tabBarController, @"%@ is not the tab bar controller currently associated with %@", tabBarController, self);
    
    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        return [[BWTabBarInteractiveTransition alloc] initWithGestureRecognizer:self.panGestureRecognizer];
    } else {
        return nil;
    }
}

@end
