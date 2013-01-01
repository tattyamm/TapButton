//
//  Configuration.h
//  TapButton
//
//  Created by tattyamm on 2013/01/01.
//  Copyright (c) 2013年 tattyamm. All rights reserved.
//

/**
 * NSUserDefaultsのWrapper
 * 参考：http://qiita.com/items/2af840ded249b3e4e9bb
 */
#import <Foundation/Foundation.h>

@interface Configuration : NSObject
+ (NSString *)scoreString;
+ (void)setScoreString:(NSString *)value;
+ (void)synchronize;
@end