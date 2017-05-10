//
//  BWPopViewController.h
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/10.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BWPopTransitionDelegate.h"

@interface BWPopViewController : UIViewController

@property (nonatomic, strong, readonly) BWPopTransitionDelegate *transitionDelegate;

- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender;

@end


