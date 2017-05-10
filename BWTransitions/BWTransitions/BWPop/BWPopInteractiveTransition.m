//
//  BWPopInteractiveTransition.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWPopInteractiveTransition.h"

@interface BWPopInteractiveTransition ()
@property (nonatomic, weak)             id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic, assign, readonly) UINavigationControllerOperation operation;
@end

@implementation BWPopInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer
                     operationForDragging:(UINavigationControllerOperation)operation{
    if (self = [super init])
    {
        _gestureRecognizer = gestureRecognizer;
        _operation = operation;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:edgeForDragging:" userInfo:nil];
}


- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}


- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Save the transitionContext for later.
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}


- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    
    UIView *transitionContainerView = self.transitionContext.containerView;
    CGPoint translationInContainerView = [gesture translationInView:transitionContainerView];
    CGFloat width = CGRectGetWidth(transitionContainerView.bounds);
//    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
    
    if (self.operation == UINavigationControllerOperationPop ||
        self.operation == UINavigationControllerOperationPush)
        return fabs(translationInContainerView.x) / width;
//    else if (self.operation == UINavigationControllerOperationPush)
//        return fabs(width - translationInContainerView.x) / width;
    else
        return 0.f;
}

- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
            // 初始化UIPercentDrivenInteractiveTransition并开始处理controllers的转场
            break;
        case UIGestureRecognizerStateChanged:
            
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:
            
            if ([self percentForGesture:gestureRecognizer] >= 0.5f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}


@end
