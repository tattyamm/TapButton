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

/**
 * usernameのgetter,setter
 * 名前が空欄だった場合に、入力を求める仕様にする（名前未入力フラグとかは立てない）
 */
+ (NSString *)usernameString {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{USERNAME_STRING_SAVE_KEY : NSLocalizedString(@"", nil)}];
    return [userDefaults objectForKey:USERNAME_STRING_SAVE_KEY];
}
+ (void)setUsernameString:(NSString *)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:USERNAME_STRING_SAVE_KEY];
}

/**
 * uidのgetter,setter
 */
+ (NSString *)uidString {
    NSUserDefaults *uidDefaults = [NSUserDefaults standardUserDefaults];
    [uidDefaults registerDefaults:@{UID_STRING_SAVE_KEY : NSLocalizedString(@"", nil)}];
    return [uidDefaults objectForKey:UID_STRING_SAVE_KEY];
}
+ (void)setUidString:(NSString *)value {
    NSUserDefaults *uidDefaults = [NSUserDefaults standardUserDefaults];
    [uidDefaults setObject:value forKey:UID_STRING_SAVE_KEY];
}

/**
 * rankのgetter,setter
 */
+ (NSString *)rankString {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{RANK_STRING_SAVE_KEY : NSLocalizedString(@"ランキング未登録", nil)}];
    return [userDefaults objectForKey:RANK_STRING_SAVE_KEY];
}
+ (void)setRankString:(NSString *)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:RANK_STRING_SAVE_KEY];
}


+ (void)synchronize {
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end