#language: ja
フィーチャ: 個人用の用語集を作成できる
  コマンドラインに不慣れな翻訳者として
  Web から用語集の作成・編集ができると嬉しい
  なぜなら logaling-command は使えないけど
  対訳用語集はあると作業が捗りそうだからだ

  背景:
    前提 ユーザ"kinoko"でログインしている
    かつ ダッシュボードを表示している

  シナリオ: 対訳用語集を新規作成できる
    前提 "Create user glossary"リンクをクリックする
    もし "Glossary name:"に"my_glossary"と入力する
    かつ "Source language:"に"en"と入力する
    かつ "Target language:"に"ja"と入力する
    かつ "Save"をクリックする
    ならば "User glossary was successfully created."と表示されていること

