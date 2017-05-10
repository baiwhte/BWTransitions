//
//  BWModalFirstViewController.m
//  BWTransitions
//
//  Created by 陈修武 on 2017/5/9.
//  Copyright © 2017年 baiwhte. All rights reserved.
//

#import "BWModalFirstViewController.h"

#import "BWModalSecondViewController.h"

@interface BWModalFirstViewController ()

@end

@implementation BWModalFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTransitionRecognizer:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        BWModalSecondViewController *viewController = [[BWModalSecondViewController alloc] init];
        BWModalTransitionDelegate *transitionDelegate = self.transitionDelegate;
        transitionDelegate.gestureRecognizer = sender;
        transitionDelegate.targetEdge = UIRectEdgeRight;
        viewController.transitioningDelegate = transitionDelegate;
        
        viewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:viewController animated:YES completion:NULL];
    }
}

- (IBAction)presentNext:(id)sender {
    
    BWModalSecondViewController *viewController = [[BWModalSecondViewController alloc] init];
    BWModalTransitionDelegate *transitionDelegate = self.transitionDelegate;

    transitionDelegate.targetEdge = UIRectEdgeRight;
    viewController.transitioningDelegate = transitionDelegate;
    
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewController animated:YES completion:NULL];
    
}

- (IBAction)dismissSelf:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
