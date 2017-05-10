//
//  BWTabBarAnimatedTransition.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

@import UIKit;

@interface BWTabBarAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

// UITabController子ViewController的滑动方向，只允许向左（UIRectEdgeLeft）或
// 向右（UIRectEdgeRight）滑动
@property (nonatomic, readwrite) UIRectEdge targetEdge;

@end
