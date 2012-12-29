//
//  AppDelegate.h
//  TapButton
//
//  Created by tatsuya endo on 2012/12/29.
//  Copyright (c) 2012年 tattyamm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window_;
    UIViewController* mainViewController_;
}

@property (nonatomic , retain) UIWindow *window;

//@property (strong, nonatomic) MainViewController *mainViewController;

@end
