//
//  BWAnimatedTransition.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/9.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

@import UIKit;

@interface BWModalAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@property (nonatomic, readwrite) UIRectEdge targetEdge;

@end
