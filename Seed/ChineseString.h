//
//  ChineseString.h
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/12.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface ChineseString : NSObject

@property (copy,nonatomic) NSString *string;
@property (copy,nonatomic) NSString *pinyin;

@end
