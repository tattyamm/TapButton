#ifndef MyConst_h //この値が定義されていなければ、この中を有効にする(複数回読み込み防止)
    #define MyConst_h

    /* 定数 */
    #define BUTTON_HEIGHT 40 //ボタンの高さ
    #define TWITTER_URL_TATTYAMM    @"https://twitter.com/tattyamm" //作者のtwitter url

    #define SCORE_STRING_SAVE_KEY    @"score_save_key"
    #define USERNAME_STRING_SAVE_KEY @"username_save_key"
    #define UID_STRING_SAVE_KEY      @"uid_save_key"
    #define RANK_STRING_SAVE_KEY     @"rank_save_key"

    /* サーバー */
    #define SCORE_SERVER_BASE_URL   @"http://scoreserver.herokuapp.com"

    #define SCORE_SERVER_RANKING_PATH          @"/ranking/game01"
    #define SCORE_SERVER_USER_REGISTER_PATH    @"/user/register"
    #define SCORE_SERVER_SCORE_REGISTER_PATH   @"/score/register"

    #define GAME_ID @"game01"  //スコアサーバーに送るこのゲームのID

    #define SCORE_SERVER_KEY_SCREENNAME @"screenName"
    #define SCORE_SERVER_KEY_LANG @"lang"
    #define SCORE_SERVER_JSON_KEY_UID @"uid"

    #define SCORE_SERVER_KEY_GAMEID @"gameId"
    #define SCORE_SERVER_KEY_SCORE @"score"
    #define SCORE_SERVER_JSON_KEY_RANK @"rank"


#endif
