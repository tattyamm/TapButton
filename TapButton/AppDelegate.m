//
//  AppDelegate.m
//  TapButton
//
//  Created by tatsuya endo on 2012/12/29.
//  Copyright (c) 2012年 tattyamm. All rights reserved.
//


#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate
@synthesize window = window_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //viewを作成
    CGRect bounds = [[UIScreen mainScreen] bounds];
    window_ = [[UIWindow alloc] initWithFrame:bounds];
    
    //そのviewをwindowに追加
    MainViewController* mainView = [[MainViewController alloc] init];
    mainViewController_ = [[UINavigationController alloc] initWithRootViewController:mainView];
    
    //これではだめ
    //[window_ addSubview:mainViewController_.view];
    //こうする(こうしないと回転しない)
    self.window.rootViewController = mainViewController_;
    
    [window_ makeKeyAndVisible];
    
    
    return 0;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//回転対応
/**
 この辺りに対応しないと、iOS5でshouldAutorotateToInterfaceOrientationが読み取られない。
 http://hiiro-game.seesaa.net/article/293374528.html
 http://iphone-app-developer.seesaa.net/article/293717318.html
 http://ken-plus.blogspot.jp/2012/09/ios6-uinavigationcontrollerautorotate.html
 */
//ios5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}
//ios6
- (BOOL)shouldAutorotate {
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    //info.plistに書いた方が優先されるらしい
	return UIInterfaceOrientationMaskAll;
}



- (void)dealloc {
}

@end