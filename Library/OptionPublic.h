//
//  OptionPublic.h
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/12.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionPublic : NSObject

#define __ScreenSize [UIScreen mainScreen].bounds.size

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;

@end
