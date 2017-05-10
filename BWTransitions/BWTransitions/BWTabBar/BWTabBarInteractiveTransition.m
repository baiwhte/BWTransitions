//
//  BWTabBarInteractiveTransition.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWTabBarInteractiveTransition.h"

@interface BWTabBarInteractiveTransition ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readwrite) CGPoint initialLocationInContainerView;
@property (nonatomic, readwrite) CGPoint initialTranslationInContainerView;


@end

@implementation BWTabBarInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self = [super init])
    {
        _gestureRecognizer = gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:" userInfo:nil];
}

- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}


- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Save the transitionContext, initial location, and the translation within
    // the containing view.
    self.transitionContext = transitionContext;
    self.initialLocationInContainerView = [self.gestureRecognizer locationInView:transitionContext.containerView];
    self.initialTranslationInContainerView = [self.gestureRecognizer translationInView:transitionContext.containerView];
    
    [super startInteractiveTransition:transitionContext];
}


- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *transitionContainerView = self.transitionContext.containerView;
    //手指移动后，在相对坐标中的偏移量
    CGPoint translationInContainerView = [gesture translationInView:transitionContainerView];
    
    // 如果当前滑动方向与初始滑动方向不匹配，则取消初始滑动；若手势继续，则使用当前滑动方向
    if ((translationInContainerView.x > 0.f && self.initialTranslationInContainerView.x < 0.f) ||
        (translationInContainerView.x < 0.f && self.initialTranslationInContainerView.x > 0.f))
        return -1.f;
    
    // Figure out what percentage we've traveled.
    return fabs(translationInContainerView.x) / CGRectGetWidth(transitionContainerView.bounds);
}


- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            // 如果-percentForGesture: 返回 -1.f 表示使用当前滑动方向覆盖初始滑动方向
            if ([self percentForGesture:gestureRecognizer] < 0.f) {
                [self cancelInteractiveTransition];
                [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
            } else {

                [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            }
            break;
        case UIGestureRecognizerStateEnded:
            
            if ([self percentForGesture:gestureRecognizer] >= 0.4f)
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
