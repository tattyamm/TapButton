//
//  Configuration.m
//  TapButton
//
//  Created by tattyamm on 2013/01/01.
//  Copyright (c) 2013年 tattyamm. All rights reserved.
//

//
//  Configuration.m
//  PresenKanpe
//
//  Created by tattyamm on 2012/12/08.
//  Copyright (c) 2012年 tattyamm. All rights reserved.
//

#import "Configuration.h"
#import "Const.h"

@implementation Configuration

/**
 * scoreStringのgetter.
 */
+ (int)scoreString {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{SCORE_STRING_SAVE_KEY : NSLocalizedString(0, nil)}];//デフォルト
    return [userDefaults integerForKey:SCORE_STRING_SAVE_KEY];
}

/**
 * scoreStringのsetter.
 */
+ (void)setScoreString:(int)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:SCORE_STRING_SAVE_KEY];
}

+ (void)synchronize {
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end