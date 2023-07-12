# README

商品管理のAPIを作る

### テーブル要件

- productsテーブル
  - id BigInt PK
  - category_id BigInt null: false FK
  - name string null: false //商品名
  - description text null: false //商品の説明
  - created_at: datetime
  - updated_at: datetime

- categoriesテーブル
  - id BigInt PK
  - name string null: false 一意の制約をつける
  - created_at: datetime
  - updated_at: datetime

### API要件

商品登録
- パラメータ
  - category_id 必須
  - name 必須
  - description 必須
- レスポンス
  - 201を返す
  - 失敗したら422を返す

商品取得
- パラメータ
  - category_id
- レスポンス
  -　下記のように返してください。
  ```
  data: [
    {
      id: 1,
      category_id: 1,
      category_name: '本'
      name: 'チェリーボン',
      description: 'rubyのチェリー本',
      created_at: '2021-10-12T10:39:04.157+09:00',
    },
    {
      id: 2,
      category_id: 2,
      category_name: 'PC'
      name: 'macbook air 2021',
      description: 'M1 macbook',
      created_at: '2021-10-12T10:39:04.157+09:00',
    },
  ]
  ```
  - 存在しないカテゴリーが指定されたら404を返す
  - パラメーターで指定されたら、指定されたidのデータを返してください
  - パラメーターが空ならば全件返してください
 
- その他
- RSpecでモデルとリクエストスペックを書いてください
- gemは便利なものがあれば入れていただいても大丈夫です
