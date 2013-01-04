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
    scoreLabel.text = [ NSString stringWithFormat : @"%@%d",NSLocalizedString(@"GameViewScoreLabel", nil) , [Configuration scoreString]];
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
    rankLabel.text = [ NSString stringWithFormat : @"%@%@",NSLocalizedString(@"GameViewRankLabel", nil), [Configuration rankString]];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.backgroundColor = [UIColor blackColor];
    rankLabel.textColor = [UIColor whiteColor];
    rankLabel.frame = CGRectMake(0,30,cgRectSize.size.width,70);
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
    scoreLabel.text = [ NSString stringWithFormat : @"%@%d",NSLocalizedString(@"GameViewScoreLabel", nil), [Configuration scoreString]];
    
}


//スコア登録
- (void)postScoreButtonDidPushed {
    NSLog(@"Pushed postScoreButton.");
    
    //初回なら、名前を登録させる。（ここの判定用にフラグが必要かも）
    //　サーバーに名前を登録し、必要な値を保存
    //２回目または名前を登録済みだったら、スコアを送信する
    //　成功なら順位を表示する
    //　失敗なら失敗したというダイアログを表示する

    //名前が空なら登録を促す
    if([Configuration usernameString] == @""){
        NSLog(@"初回ユーザー登録");
        [self showAlertView];
    }else{
        //ユーザー登録済みなので、スコア送信
        NSLog(@"userName:%@ uid:%@",[Configuration usernameString],[Configuration uidString]);
        NSLog(@"スコア送信");
        [self postScore:[Configuration scoreString] uid:[Configuration uidString] gameId:GAME_ID];
    }

}

//ユーザー登録
// ユーザー登録が完了したら、必ずスコアも登録する仕様
-(void) registerUserWithScreenname:(NSString *)screenname {

    NSURL *url = [NSURL URLWithString:SCORE_SERVER_BASE_URL];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            screenname, SCORE_SERVER_KEY_SCREENNAME,
                            [[NSLocale preferredLanguages] objectAtIndex:0],SCORE_SERVER_KEY_LANG,
                            nil];
    
    for (id key in params) {
        NSLog(@"key: %@, value: %@ \n", key, [params objectForKey:key]);
    }
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:SCORE_SERVER_USER_REGISTER_PATH parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"取得したuid: %@", [JSON valueForKeyPath:SCORE_SERVER_JSON_KEY_UID]);
        [Configuration setUidString:[JSON valueForKeyPath:SCORE_SERVER_JSON_KEY_UID]];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //スコア登録の呼び出し
        [self postScore:[Configuration scoreString] uid:[JSON valueForKeyPath:SCORE_SERVER_JSON_KEY_UID]gameId:GAME_ID];
        
    } failure:nil];
    
    //start
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [operation start];
}

//スコア登録 POST
-(void) postScore:(int)score uid:(NSString *)uid gameId:(NSString *)gameId{

    NSURL *url = [NSURL URLWithString:SCORE_SERVER_BASE_URL];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [ NSString stringWithFormat : @"%d", score ], SCORE_SERVER_KEY_SCORE,
                            uid, SCORE_SERVER_JSON_KEY_UID,
                            gameId, SCORE_SERVER_KEY_GAMEID,
                            nil];
    
    for (id key in params) {
        NSLog(@"key: %@, value: %@ \n", key, [params objectForKey:key]);
    }

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:SCORE_SERVER_SCORE_REGISTER_PATH parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"取得したRank: %@", [JSON valueForKeyPath:SCORE_SERVER_JSON_KEY_RANK]);
        rankLabel.text = [ NSString stringWithFormat : @"%@%@", NSLocalizedString(@"GameViewScoreLabel", nil),[JSON valueForKeyPath:SCORE_SERVER_JSON_KEY_RANK]];
        [Configuration setRankString:[JSON valueForKeyPath:SCORE_SERVER_JSON_KEY_RANK]];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:nil];
    
    //start
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [operation start];
}



//AlertView表示
- (void)showAlertView{
    // UIAlertViewの生成
    //   http://www.amuate.com/2012/04/07/alertviewandtextfield.html
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"GameViewUsernameAlertTitle", nil) 
                                                        message:@" "
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"GameViewUsernameAlertCancel", nil)
                                              otherButtonTitles:NSLocalizedString(@"GameViewUsernameAlertOk", nil), nil];
    // UITextFieldの生成
    alertViewTextfield = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
    alertViewTextfield.borderStyle = UITextBorderStyleRoundedRect;
    alertViewTextfield.textAlignment = UITextAlignmentLeft;
    alertViewTextfield.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    alertViewTextfield.textColor = [UIColor grayColor];
    alertViewTextfield.minimumFontSize = 8;
    alertViewTextfield.adjustsFontSizeToFitWidth = YES;
    alertViewTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    alertViewTextfield.delegate = self;
    alertViewTextfield.text = alertviewButton.titleLabel.text;
    [alertView addSubview:alertViewTextfield];
    // アラート表示
    [alertView show];
    // テキストフィールドをファーストレスポンダに
    [alertViewTextfield becomeFirstResponder];
}

//AlertViewのテキスト入力内容を受け取る
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // OKが選択された場合
    if (buttonIndex == 1) {
        // テキストフィールドに一文字以上入力されていた場合
        if ([alertViewTextfield.text length]) {
            // ボタンタイトルにテキストフィールドのテキストを設定
            NSLog(@"AlertView入力内容 %@",alertViewTextfield.text);
            [Configuration setUsernameString: alertViewTextfield.text];

            //ユーザー登録
            [self registerUserWithScreenname:alertViewTextfield.text];
            
        }else{
            //空のままOKボタン押されたら、再度ダイアログ表示
            [self showAlertView];
        }
    }
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
