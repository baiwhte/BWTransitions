//
//  BWInteractiveTransition.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/9.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

@import UIKit;

@interface BWModalInteractiveTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer edgeForDragging:(UIRectEdge)edge NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
