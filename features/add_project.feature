#language: ja

フィーチャ: .logaling を持つ github 上の翻訳プロジェクトを登録したい
  .logaling を持つ github 上の翻訳プロジェクトに参加している翻訳者として
  プロジェクトを登録したい
  なぜなら、ブラウザからでも訳語を検索したいからだ

  シナリオ: .logaling を持つ github プロジェクトを登録できる
    前提   プロジェクト登録画面を表示する
    もし   "logaling"ユーザの"logaling-server"プロジェクトを登録する
    ならば "logaling"ユーザの"logaling-server"プロジェクトが登録済みであること
