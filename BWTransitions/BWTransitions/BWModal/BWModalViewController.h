//
//  BWBaseViewController.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/8.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BWModalTransitionDelegate.h"



@interface BWModalViewController : UIViewController

@property (nonatomic, strong, readonly) BWModalTransitionDelegate *transitionDelegate;

- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender;
@end
