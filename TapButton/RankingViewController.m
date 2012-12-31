//
//  RankingViewController.m
//  TapButton
//
//  Created by tatsuya endo on 2012/12/30.
//  Copyright (c) 2012年 tatsuya endo. All rights reserved.
//

#import "RankingViewController.h"

@interface RankingViewController ()

@end

@implementation RankingViewController

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

    //uiwebview表示
    //http://iphone-tora.sakura.ne.jp/uiwebview.html
    UIWebView *wv = [[UIWebView alloc] init];
    wv.delegate = self;
    wv.frame = CGRectMake(0, 0, cgRectSize.size.width, cgRectSize.size.height-navBarHeight);
    wv.scalesPageToFit = NO;
    [self.view addSubview:wv];
    
    NSURL *url = [NSURL URLWithString:@"http://scoreserver.herokuapp.com/ranking/game01"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [wv loadRequest:req];

}

// アクティビティインジケータ開始
-(void)webViewDidStartLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// アクティビティインジケータ終了
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
