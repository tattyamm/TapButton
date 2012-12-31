//
//  MainViewController.m
//  TapButton
//
//  Created by tatsuya endo on 2012/12/29.
//  Copyright (c) 2012年 tattyamm. All rights reserved.
//

#import "MainViewController.h"
#import "AboutViewController.h"
#import "RankingViewController.h"
#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>   //UITextFieldの枠線や、UIButtonの背景色を設定するのに使った


@implementation MainViewController

-(id)init{
    self.title=NSLocalizedString(@"MainViewTitleText", nil);
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //navigationBar部分
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //  iボタンを追加
    //  http://d.hatena.ne.jp/chaoruko/20120203/1328236510
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self
                   action:@selector(infoButtonDiDPushed)
         forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    /*
    //  決定ボタンを追加（右上）
    UIBarButtonItem *goButton = [[UIBarButtonItem alloc]
                                 initWithTitle:NSLocalizedString(@"MainViewDoneButton", nil)
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(goButtonDidPushKanpe)];
    self.navigationItem.rightBarButtonItem = goButton;
     */
    //  戻るボタンの変更
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"arrow_left_24.png"]
                                   style:UIBarButtonItemStyleBordered
                                   target:nil
                                   action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    
    //画面サイズ取得
    CGRect cgRectSize = [[UIScreen mainScreen] applicationFrame];//ステータスバーを除いた画面サイズ
    //NavigationBarの高さ取得
    CGFloat navBarHeight  = self.navigationController.navigationBar.frame.size.height;
    
    
    //ラベル
    UILabel* label = [[[UILabel alloc] initWithFrame:self.view.bounds] autorelease];
    label.text = @"表示する文字を入力して下さい";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(0,0,cgRectSize.size.width,70);
    label.textAlignment = UITextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:label];
    
    //ボタン ゲーム
    MyCustomButton *goGameButton = [[MyCustomButton alloc] init];
    goGameButton.frame = CGRectMake(0 , cgRectSize.size.height-navBarHeight-BUTTON_HEIGHT*2
                                       ,cgRectSize.size.width,BUTTON_HEIGHT);
    [goGameButton setTitle:NSLocalizedString(@"MainViewGoGameButton", nil) forState:UIControlStateNormal];
    [goGameButton addTarget:self
                        action:@selector(goGameButtonDidPushed)
              forControlEvents:UIControlEventTouchUpInside];
    [goGameButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [self.view addSubview:goGameButton];

    //ボタン ランキング
    MyCustomButton *goRankingButton = [[MyCustomButton alloc] init];
    goRankingButton.frame = CGRectMake(0 , cgRectSize.size.height-navBarHeight-BUTTON_HEIGHT
                                       ,cgRectSize.size.width,BUTTON_HEIGHT);
    [goRankingButton setTitle:NSLocalizedString(@"MainViewGoRankingButton", nil) forState:UIControlStateNormal];
    [goRankingButton addTarget:self
                        action:@selector(goRankingButtonDidPushed)
              forControlEvents:UIControlEventTouchUpInside];
    [goRankingButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [self.view addSubview:goRankingButton];

    
    
}


//画面遷移
- (void)goRankingButtonDidPushed {
    RankingViewController* ranking = [[[RankingViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ranking animated:YES];
}

//画面遷移
- (void)goGameButtonDidPushed {
    GameViewController* ranking = [[[GameViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ranking animated:YES];
}

//画面遷移
- (void)infoButtonDiDPushed {
    AboutViewController* kanpe = [[[AboutViewController alloc] init] autorelease];
    [self.navigationController pushViewController:kanpe animated:YES];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [textView_ release];
    [super dealloc];
}

@end
