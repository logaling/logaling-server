#language: ja

フィーチャ: 用語を検索したい
  翻訳者として
  訳語を選定中の用語を検索したい
  なぜなら、他の人たちがどう訳しているか気になるからだ

  シナリオ: 登録されている用語の検索
    前提 "logaling"ユーザの"logaling-server"プロジェクトが登録済みである
    かつ トップページを表示している
    もし "logaling server"と検索する
    ならば "logaling サーバ"と表示されていること

  シナリオ: 登録されていない用語の検索
    前提 "logaling"ユーザの"logaling-server"プロジェクトが登録済みである
    かつ トップページを表示している
    もし "groonga"と検索する
    ならば "groonga は見つかりませんでした。"と表示されていること

  シナリオ: 検索ワードに何も入力せずに検索ボタンをクリックした場合
    前提 トップページを表示している
    もし ""と検索する
    ならば "単語/フレーズを入力して検索してください"と表示されていること

  シナリオ: /search にパラメータを付けずに直接アクセスした場合
    もし "/search"にパラメータを付けずに直接アクセスする
    ならば "単語/フレーズを入力して検索してください"と表示されていること
