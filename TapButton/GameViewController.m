//
//  GameViewController.m
//  TapButton
//
//  Created by tatsuya endo on 2013/01/01.
//  Copyright (c) 2013年 tatsuya endo. All rights reserved.
//

#import "GameViewController.h"
#import "RankingViewController.h"
#import "STDeferred.h"
#import "AFURLConnectionOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize scoreLabel;
@synthesize rankLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //viewの設定
    self.view.backgroundColor = [UIColor blackColor];
    
    //画面サイズ取得
    CGRect cgRectSize = [[UIScreen mainScreen] applicationFrame];//ステータスバーを除いた画面サイズ
    //NavigationBarの高さ取得
    CGFloat navBarHeight  = self.navigationController.navigationBar.frame.size.height;

    //ラベル score
    scoreLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    scoreLabel.text = [ NSString stringWithFormat : @"スコア：%d", [Configuration scoreString]];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.backgroundColor = [UIColor blackColor];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.frame = CGRectMake(0,0,cgRectSize.size.width,70);
    scoreLabel.textAlignment = UITextAlignmentLeft;
    scoreLabel.adjustsFontSizeToFitWidth = YES;
    scoreLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scoreLabel];
    
    //ラベル rank
    rankLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    rankLabel.text = [ NSString stringWithFormat : @"ランク：%@", [Configuration rankString]];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.backgroundColor = [UIColor blackColor];
    rankLabel.textColor = [UIColor whiteColor];
    rankLabel.frame = CGRectMake(0,100,cgRectSize.size.width,70);
    rankLabel.textAlignment = UITextAlignmentLeft;
    rankLabel.adjustsFontSizeToFitWidth = YES;
    rankLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:rankLabel];
    
    
    //ボタン カウントするボタン
    MyCustomButton *countButton = [[MyCustomButton alloc] init];
    countButton.frame = CGRectMake(0 , cgRectSize.size.height-navBarHeight-BUTTON_HEIGHT*3
                                       ,cgRectSize.size.width,BUTTON_HEIGHT);
    [countButton setTitle:NSLocalizedString(@"GameViewCountButton", nil) forState:UIControlStateNormal];
    [countButton addTarget:self
                        action:@selector(countButtonDidPushed)
              forControlEvents:UIControlEventTouchUpInside];
    [countButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [self.view addSubview:countButton];
    
    //ボタン スコア登録
    MyCustomButton *postScoreButton = [[MyCustomButton alloc] init];
    postScoreButton.frame = CGRectMake(0 , cgRectSize.size.height-navBarHeight-BUTTON_HEIGHT*2
                                       ,cgRectSize.size.width,BUTTON_HEIGHT);
    [postScoreButton setTitle:NSLocalizedString(@"GameViewPostScoreButton", nil) forState:UIControlStateNormal];
    [postScoreButton addTarget:self
                        action:@selector(postScoreButtonDidPushed)
              forControlEvents:UIControlEventTouchUpInside];
    [postScoreButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [self.view addSubview:postScoreButton];
    
    //ボタン ランキング
    MyCustomButton *goRankingButton = [[MyCustomButton alloc] init];
    goRankingButton.frame = CGRectMake(0 , cgRectSize.size.height-navBarHeight-BUTTON_HEIGHT
                                       ,cgRectSize.size.width,BUTTON_HEIGHT);
    [goRankingButton setTitle:NSLocalizedString(@"GameViewGoRankingButton", nil) forState:UIControlStateNormal];
    [goRankingButton addTarget:self
                        action:@selector(goRankingButtonDidPushed)
              forControlEvents:UIControlEventTouchUpInside];
    [goRankingButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [self.view addSubview:goRankingButton];
    
}

//カウントするボタン
- (void)countButtonDidPushed {
    NSLog(@"Pushed countButtonDidPushed.");
    
    //値を読み出し、+1して、値を戻し、表示を更新
    //これ、文字列を保存しちゃっているので、数字を保存するように変更する
    //http://iphone-dev.g.hatena.ne.jp/tokorom/20090520/1242789479
    
    //Debug 値の取り出し
    //NSLog( @"%d", [Configuration scoreString] );
    //入力文字の保存
    [Configuration setScoreString: [Configuration scoreString]+1];
    //Debug もう１回値を取り出す
    //NSLog( @"%d", [Configuration scoreString] );
    
    //Labelの更新
    scoreLabel.text = [ NSString stringWithFormat : @"スコア：%d", [Configuration scoreString]];
    
}


//スコア登録
- (void)postScoreButtonDidPushed {
    NSLog(@"Pushed postScoreButton.");
    
    //初回なら、名前を登録させる。（ここの判定用にフラグが必要かも）
    //　登録
    //　　名前、UID、rank、を保存する
    //   TODO 国も送りたい NSString *language = NSLocalizedString(@"Language", nil);
    //   TODO 送信時はボタンを無効化し、くるくる動かす
    //２回目または名前を登録済みだったら、スコアを送信する
    //　成功なら順位を表示する
    //　失敗なら失敗したというダイアログを表示する


#warning 作成中
    //GET
    NSURL *url2 = [NSURL URLWithString:@"http://httpbin.org/ip"];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    
    AFJSONRequestOperation *operation2 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request2 success:^(NSURLRequest *request2, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"IP Address: %@", [JSON valueForKeyPath:@"origin"]);
    } failure:nil];
    
    //[operation2 start];
    
    //POST
    NSURL *url = [NSURL URLWithString:@"http://scoreserver.herokuapp.com/"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"100", @"score",
                            @"e0365d12-3782-4c95-92bd-e2ad6b61e520", @"uid",
                            @"game01", @"gameId",
                            nil];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"score/register" parameters:params];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"IP Address: %@", [JSON valueForKeyPath:@"rank"]);
    } failure:nil];
    
    [operation start];
}

//画面遷移
- (void)goRankingButtonDidPushed {
    RankingViewController* ranking = [[RankingViewController alloc] init];
    [self.navigationController pushViewController:ranking animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
