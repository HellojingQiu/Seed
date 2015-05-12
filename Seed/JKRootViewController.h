//
//  JKRootViewController.h
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/11.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKRootViewController : UITabBarController

@property (strong,nonatomic) NSArray *arrayButtons;
@property (strong,nonatomic) UIImageView *slideBg;
@property (assign,nonatomic) int currentSelectedIndex;


-(void)selectedTab:(id)sender;
@end
