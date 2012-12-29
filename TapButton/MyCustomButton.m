//
//  MyCustomButton.m
//  PresenKanpe
//
//  Created by entatsu on 2012/11/24.
//  Copyright (c) 2012年 entatsu. All rights reserved.
//

#import "MyCustomButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 * Only override drawRect: if you perform custom drawing.
 * An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //NSLog(@"MyCustomButton drawRect");
    
    //UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [[self layer] setCornerRadius:20.0f];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setBorderWidth:2.0f];
    [[self layer] setBackgroundColor:[[UIColor blackColor] CGColor]];
    [[self layer] setBorderColor:[[UIColor whiteColor] CGColor]];

    /* 自分で書く必要がある部分
    [button setTitle:@"ボタン" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonDidPush)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0,cgRectSize.size.height-navBarHeight-BUTTON_HEIGHT
                              ,cgRectSize.size.width,BUTTON_HEIGHT);
    [button setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];//これはデザインに関する事なのでCustomViewに入れたいのだが、signal SIGABRTで落ちる。
    [self.view addSubview:button];
     */
    
}

@end
