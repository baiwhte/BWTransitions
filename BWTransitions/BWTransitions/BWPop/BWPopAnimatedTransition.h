//
//  BWPopAnimatedTransition.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

@import UIKit;

@interface BWPopAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetOperation:(UINavigationControllerOperation)targetOperation;

@property (nonatomic, readwrite) UINavigationControllerOperation targetOperation;

@end
