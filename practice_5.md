# モデルに命を与える
## 5.1 モデルの役割
### 5.1.1 モデルとActiveRecord
#### Bookモデルがある時
Book < ApplicationRecord < ActiveRecord::Base
といった継承関係にある。
#### できること
- 親クラスのメソッドを使用できる
#### これまでの捉え方との違い
これまでは、なんだかわからないが`Book.new(title: "タイトル", text: "本の感想です。")`とするだけで、
データを新規登録するための準備ができ、saveメソッドでデータベースに保存される。とだけ考えていた。

しかし、実際はBookクラスに初期値を与え、インスタンス化していた。  
findやallメソッドもインスタンス化していたことを知った。  
また、titleなども値を定義して代入しているだけだと思っていたが、実際は同じ名前でメソッドが内部的に定義されており、  
インスタンスした後にbook.titleという形のインスタンスメソッドとして扱っていたことを知った。

#### ActiveRecordの役割
データベースのテーブルとモデルの関係付けを行う役割を担っている。
そして、一般的にそのような役割を担う仕組みをORM(オブジェクト・リレーショナル・マッピング)という。
SQL文はデータベースごとに方言があり、それを変換する仕事をしている。
具体的には、データベースを処理するためのモデルのメソッドを呼び出すと、利用しているデータベースのSQL文に変換され、テーブルに対してSQL文が実行される。  
ActiveRecord(ORM)があるため、データベースが違っても、SQL文の形式や文法の違いを考えることなく同じメソッドを使用して同じy方に処理ができる。

ActiveRecordは、1レコードに対して、1モデルのインスタンスとして生成する。  
そして、テーブルのカラムの名前と同じメソッドを使って、インスタンスが持つ属性とやり取りする。  
例えば、  
Bookモデルのtitle属性は、  
booksテーブルのtitleカラムに対応しており、  
Bookモデルのインスタンスは、titleメソッドを使用して、タイトルの値を取得できる。

#### 練習問題 5.1
1. ActiveRecordとORMの関係について説明してください。
  - 解答
    同じ役割を担う仕組み。ActiveRecordはRailsにおけるORMである。  
    具体的にORMとはオブジェクト・リレーショナル・マッピングの略称で、モデルとデータベースを関係付ける役割を担う。  
    モデルでのデータベースへの操作をSQL文に変換して処理を行う。  
    SQL文は、データベースごとに方言があるため、使用データベースごとに変更する必要があるが、ORMがそれをやってくれる。
  - 正解
    正解
2. モデルに定義した属性は、どこにどのように実装されているか説明してください。
  - 解答
    モデルに定義した属性は、テーブルのカラムに保存される。  
    それらはモデルのインスタンス化により、インスタンスメソッドとして定義され、呼び出すことで表示させることができる。
  - 正解
    正解
3. モデルの属性の値を取得する場合、どのように行うのかを説明してください。
  - 解答
    モデルの属性の値を取得するには、インスタンス化して属性名と同じ名前のインスタンスメソッドで呼び出すことができる。
  - 正解
    モデルインスタンスの「項目名と同名のメソッド」で、テーブルに登録された値を取得できる。
4. モデルに実装される機能には、どのようなものがあるか例示してください。
  - 解答
    CRUD機能、バリデーション
  - 正解
    データリソースのライフサイクルを実現する機能  
    データリソースの個々の属性の正当性を保証し、正常に保つ機能  
    データリソースの処理の対象範囲を制御する機能  
    モデル同士の相互の関係を適切に保つ機能  
    データリソース内の整合性を保証する機能  
    データリソースをよりスマートに管理する機能  


## 5.2 モデルの作成

### 5.2.1 モデルの作成手順とモデル生成
1. 対象となるモデルを生成する
2. マイグレーションを行い、モデルに対応するテーブルを作成する
3. モデルの基本の検証を行う
4. 動作検証に基づいて、モデルに必要な機能を追加する

- 予想
1. rails g model book title:string text:text
2. rails db:migrate
3. ??
4. ??

- 答え
1. rails cでデータを登録したり、allメソッドetcで検証する。

#### モデル名のルール
- キャメル形式  
  UserAddress
- スネーク形式  
  user_address
- コマンド入力時のモデル名  
  英小文字単数 book user_address
- 生成モデル名  
  先頭大文字キャメル形式 単数形 Book UserAddress
- 生成テーブル名  
  英小文字複数形 books user_addresses

#### 属性のオプション
モデルの属性に対して、:で続けて記述することでオプションをつけることができる。  
例：userモデルのemailは重複しないデータにしたい場合。
```bash
$ rails g user name:string email:string:uniq
```

例：対象の属性をインデックスキーとして使用するためのオプション
```bash
$ rails g user name:string number:integer:index
```

#### 練習問題 5.2
1. モデルの生成時に自動で付与される属性を列挙し、それぞれの役割を説明してください。
  - 解答
    - 主キー
      検索用に自動付与されるinteger型の属性
    - 生成日時(created_at)
      生成日時をdate型で記録する属性
    - 更新日時(updated_at)
      更新日時をdate型で記録する属性

  - 正解
    - 主キーはid
    - 登録日と更新日はtimestamps型
    だいたい正解

## 5.3 マイグレーションとシード機能
### 5.3.2 マイグレーションのコマンドと操作
未反映のマイグレーションファイルを元に、データベースおよびschema.rbを更新する。
```bash
$ rails db:migrate
```

現在の（実行済みの）マイグレーションのバージョンを表示
```bash
$ rails db:version
```

マイグレーションの実行状況を一覧表示する。
```bash
$ rails db:migrate:status
```

データベースやスキーマを削除し、再実行する
```bash
$ rails db:migrate:reset
```

db:create db:schema:load db:seedを一括で行う
```bash
$ rails db:setup
```

db:drop db:setupを一括で行う
```bash
$ rails db:reset
```

マイグレーションを一つ前に戻す  
データを含む場合は削除される
```bash
$ rails db:rollback
```

マイグレーションを指定の数だけ戻す  
戻したテーブルは再構成されるため初期状態になる。
```bash
$ rails db:rollback STEP=3
```

現在のスキーマファイルからデータベースを作成する
```bash
$ rails db:schema:load
```

現在のデータベースからスキーマを作成する
```bash
$ rails db:schema:dump
```

現在のデータベースを全て削除する
```bash
$ rails db:drop
```

マイグレーションの一つ前のバージョンへの戻しを実行し、ステータスを確認する。
```bash
# ステータスの確認（実行状況）
$ rails db:migrate:status
# ロールバック
$ rails db:rollback
```

### 5.3.3 マイグレーション名の付け方
モデルに必要になった属性（カラム）を存在するテーブルに追加する際にマイグレーションファイルを作成する必要がある。

- テーブルを新規に作成する：create_テーブル名
- 既存テーブルに新しいカラムを追加する：add_カラム名_to_テーブル名
- 既存テーブルからカラムを削除する：remove_カラム名_from_テーブル名
- 多対多の関係の仲介テーブル「habtm(has_belongs_to_many)用のテーブル」を作成する：create_join_table_モデル名_モデル名

#### 新規にテーブルを作成するパターン
一般的にはモデルの生成での自動作成を行う。
例としてFoodモデルにnameカラムをstring型で作成する
```bash
$ rails g model food name:string
```

#### 既存のテーブルにカラムを追加するパターン
上記のFoodモデルにdescriptionというカラムをstring型で追加する
```bash
$ rails g migration add_description_to_foods description:string
```

#### 既存のテーブルのカラム属性を変更するパターン
descriptionカラムをstring型からtext型へ変更する
```bash
$ rails g migration change_datatype_description_of_foods
```
上記のコマンドによって下記のようなファイルが生成される
```ruby
class ChangeDatatypeDescriptionOfFoods < ActiveRecord::Migration[5.2]
  def change
  end
end
```
処理内容はchange_columnメソッドを使用して記述する  
下記のコードは、foodsテーブルのdescriptionの属性タイプをtextとし、初期値として"食事の内容を記述"を設定する処理
```ruby
class ChangeDatatypeDescriptionOfFoods < ActiveRecord::Migration[5.2]
  def change
    change_column :foods, :description, :text, default:"食事の内容を記述"
  end
end
```

#### 既存のテーブルのカラムを差し替えるパターン
上記の方法とは異なる、汎用的なやり方としては、"古いカラムを削除して、新しいカラムを追加する"という方法
その方法で作成した場合  
- コマンド
```bash
$ rails g migration change_attributes_of_foods
```
- マイグレーションファイル
```ruby
class ChangeAttributesOfFoods < ActiveRecord::Migration[5.2]
  # 追加
  def up
    change_table :foods do |t|
      t.change :name, :string, default: "食事の名前"
    end
  end
  
  # 削除
  def down
    change_table :foods do |t|
      t.change :name, :string
    end
  end
end
```
また、reversibleを使って下記のように書くことも可能
```ruby
class ChangeAttributesOfFoods < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :foods do |t|
        # 追加
        dir.up { t.change :name, :string, default: "食事の名前" }
        # 削除
        dir.down { t.change :name, :string }
      end
    end
  end
end
```

#### 既存のカラム属性をインデックスにするパターン
Userモデルが持つemailカラムを検索処理に使用する場合。
- コマンド
```bash
$ rails g migration add_index_email_to_users
```
- マイグレーションファイル
```ruby
class AddIndexEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
  end
end
```

### 5.3.7 シード機能
あらかじめテーブルに入れておきたいリソースを登録しておくことができる。  
```bash
$ rails db:seed
```
このコマンドは既に登録されているデータを考慮しないため、  
繰り返し実行すると、データ関係に矛盾が発生しない限り、  
同じものが繰り返し登録されていく。
データの追加ではなく、データベースを再作成したい場合は、「rails db:setup」を使用する。
これはテーブルの初期化と、seed再実行を一括して行ってくれる。

#### シードの実装例
モデルのcreateメソッドを使用する。newとsaveを一括してくれる。
```ruby
Food.create(name:"ラーメン", description: "中国から伝わった麺が日本流に様々にアレンジされています")
Food.create(name:"寿司", description: "日本独特の食文化を作り出しています")
```
- 実行コマンド
```bash
$ rails db:seed
```
#### 練習問題 5.3
1. マイグレーションの目的について説明してください。
  - 解答
    マイグレーションファイルを元に、データベースに設定を反映させること。
  - 正解
  
2. マイグレーションファイルを作成する方法を2つ挙げてください。
  - 解答
    rails g model 属性名:タイプ  
    もしくは  
    rails g migration マイグレーションファイル名
  - 正解
  
3. 一度マイグレーションを行って作成したデータベースを全て取り消し、作り直す手順を、具体的に説明してください。  
   また、その操作をLibraryアプリケーションに対して、実際に行ってみてください。
  - 解答
    rails db:drop
    rails db:migrate
  - 正解
  
4. マイグレーションの結果が正しくなかった場合に、最新のマイグレーションとテーブルの内容を取り消す方法を具体的に説明してください。
  - 解答
    rails db:rollback
  - 正解
  
5. マイグレーションファイルのファイル名について、最低限必要なルールを説明してください。
  - 解答
    スネーク型で記述すること  
    処理の内容をadd_カラム名_to_テーブル名のように記述すること
  - 正解
  
6. スキーマの役割とマイグレーションとの関係について説明してください。  
   また、スキーマの生成場所について説明してください。
  - 解答
    スキーマは現在実行済みのマイグレーションファイルの結果を反映したものが記述されている。

    生成場所は、dbディレクトリ内にschema.rbで生成される。
  - 正解
  



## 5.4 CRUD操作と標準装備のメソッド
## 5.5 まとめ