//
//  BWPopInteractiveTransition.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWPopInteractiveTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer
                     operationForDragging:(UINavigationControllerOperation)operation NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
