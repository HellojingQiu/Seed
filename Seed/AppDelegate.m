//
//  AppDelegate.m
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/7.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWIntroductionViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (strong,nonatomic) ZWIntroductionViewController *introductionView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSArray *converImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    NSArray *backgorundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    NSArray *titleArray = @[@"微信登录",@"注册",@"登录"];
    
    self.introductionView = [[ZWIntroductionViewController alloc]initWithCoverImageNames:converImageNames backgroundImageNames:backgorundImageNames buttons:titleArray];
    
    [self.window addSubview:self.introductionView.view];
    
    __weak AppDelegate *weakSelf = self;
    
    self.introductionView.didSelectedEnter = ^(){
        [weakSelf.introductionView.view removeFromSuperview];
        weakSelf.introductionView = nil;
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        weakSelf.window.rootViewController = [main instantiateInitialViewController];
        [weakSelf.window makeKeyAndVisible];
    };
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//test github
@end
