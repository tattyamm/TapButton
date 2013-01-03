#ifndef MyConst_h //この値が定義されていなければ、この中を有効にする(複数回読み込み防止)
    #define MyConst_h

    /* 定数 */
    #define BUTTON_HEIGHT 40 //ボタンの高さ
    #define TWITTER_URL_TATTYAMM    @"https://twitter.com/tattyamm" //作者のtwitter url
    #define RANKING_TOP_URL         @"http://scoreserver.herokuapp.com/ranking/game01"  //rankingのviewで最初に開くページ
    //#define RANKING_TOP_URL         @"http://localhost:9000"

    #define SCORE_STRING_SAVE_KEY    @"score_save_key"
    #define USERNAME_STRING_SAVE_KEY @"username_save_key"
    #define UID_STRING_SAVE_KEY      @"uid_save_key"
    #define RANK_STRING_SAVE_KEY     @"rank_save_key"
#endif
