#language: ja

フィーチャ: .logaling を持つ github 上の翻訳プロジェクトを登録したい
  .logaling を持つ github 上の翻訳プロジェクトに参加している翻訳者として
  プロジェクトを登録したい
  なぜなら、ブラウザからでも訳語を検索したいからだ

  シナリオ: .logaling を持つ github プロジェクトを登録できる
    前提   プロジェクト登録画面を表示する
    もし   "logaling"ユーザの"logaling-server"プロジェクトを登録する
    ならば "logaling"ユーザの"logaling-server"プロジェクトが登録済みであること

  シナリオ: 登録済みの github プロジェクトは重複して登録できない
    前提   "logaling"ユーザの"logaling-server"プロジェクトが登録済みである
    かつ   プロジェクト登録画面を表示する
    もし   "logaling"ユーザの"logaling-server"プロジェクトを登録する
    ならば "プロジェクトはすでに存在します"と表示されていること

  シナリオ: .logaling を持たない github プロジェクトは登録できない
    前提   プロジェクト登録画面を表示する
    もし   "logaling"ユーザの"logaling-command"プロジェクトを登録する
    ならば "プロジェクトには対訳用語集が存在しません"と表示されていること
