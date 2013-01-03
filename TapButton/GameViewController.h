//
//  GameViewController.h
//  TapButton
//
//  Created by tatsuya endo on 2013/01/01.
//  Copyright (c) 2013年 tatsuya endo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController{
    UILabel *scoreLabel;
    UILabel *rankLabel;
}
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) UILabel *rankLabel;
@end
