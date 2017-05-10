//
//  BWTransitionDelegate.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/9.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

@import UIKit;


@interface BWModalTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

//! If this transition will be interactive, this property is set to the
//! gesture recognizer which will drive the interactivity.
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readwrite) UIRectEdge targetEdge;


@end
