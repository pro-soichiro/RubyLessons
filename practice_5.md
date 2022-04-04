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
1.マイグレーションの目的について説明してください。
  - 解答
    マイグレーションファイルを元に、データベースに設定を反映させること。
  - 正解
    マイグレーションファイルを使って、Rails側から別世界にあるデータベースを作成・更新するための作業
    マイグレーションの機能によって、データベースの深い知識がなくても、必要なデータベースのテーブルをRails側から簡単に生成することができる。
2.マイグレーションファイルを作成する方法を2つ挙げてください。
  - 解答
    rails g model 属性名:タイプ  
    もしくは  
    rails g migration マイグレーションファイル名
  - 正解
    正解
  
3.一度マイグレーションを行って作成したデータベースを全て取り消し、作り直す手順を、具体的に説明してください。  
   また、その操作をLibraryアプリケーションに対して、実際に行ってみてください。
  - 解答
    rails db:drop
    rails db:migrate
  - 正解
    rails db:migrate:reset

4.rails db:migrate ,rails db:migrate:reset ,rails db:reset  について違いを説明してください。
  - 正解
    - db:migrate
      実行していないマイグレーションファイルを実行するコマンド
    - db:migrate:reset
      一度全てのデータベースを削除し、再度全てのマイグレーションファイルを実行するコマンド
    - db:reset
      一度全てのデータベースを削除し、再度全てのマイグレーションファイルを実行した上で、db:seedにて初期データを登録するコマンド
  - 解答
    - db:migrate
      正解
    - db:migrate:reset
      スキーマも削除する。
    - db:reset
      データベースの削除（db:drop）、データベースの再作成（db:setup）を一括して行う。  
      このコマンドはスキーマの情報を元にデータベースを構築するため、マイグレーションファイルは通過しない。

#### マイグレーションのコマンド
| - | - | - | - |
| ---- | ---- | ---- | ---- |
| db:reset | 下記2つを包括 |  |  |
|  | db:drop | データベースの削除 |  |
|  | db:setup | 下記3つを包括 |  |
|  |  | db:create | データベースの作成 |
|  |  | db:schema:load | スキーマからのテーブル作成 |
|  |  | db:seed | 初期データの登録 |

7.マイグレーションの結果が正しくなかった場合に、最新のマイグレーションとテーブルの内容を取り消す方法を具体的に説明してください。
  - 解答
    rails db:rollback
  - 正解
    正解
  
8.マイグレーションファイルのファイル名について、最低限必要なルールを説明してください。
  - 解答
    スネーク型で記述すること  
    処理の内容をadd_カラム名_to_テーブル名のように記述すること
  - 正解
    任意でつけることができるが、Railsの標準的な規約に従って名前をつけることにより、付加するオプションに応じて、マイグレーションに必要なメソッドを記述したスケルトンを自動で生成できる。
  
9.スキーマの役割とマイグレーションとの関係について説明してください。  
   また、スキーマの生成場所について説明してください。
  - 解答
    スキーマは現在実行済みのマイグレーションファイルの結果を反映したものが記述されている。

    生成場所は、dbディレクトリ内にschema.rbで生成される。
  - 正解
    スキーマとは、最新のデータベースのテーブル構造などを反映した情報であり、  
    スキーマファイルとは、rails db:migrateコマンドによってマイグレーションを実行した結果、dbディレクトリ上に生成されるファイル。
  
## 5.4 CRUD操作と標準装備のメソッド
### 5.4.2 Create:作成メソッド（新規保存）
create実行時にバリデーションでエラーが発生した場合は、再処理を行う必要があるが、createメソッドではこのエラーをfalseとして評価できない。  
そのため、通常の処理ではsaveメソッドを使う。

### 5.4.3 Read:読み出しメソッド（取得）
#### find(id)
引数のカッコは、スペースを使うことで省略も可能
```ruby
Item.find(1)
Item.find 1
```
IDを複数指定した場合。配列化して取得可能
```ruby
Item.find(1,3,5)
```

#### find_by(条件)
例：name:"山田太郎"であるUserモデルのオブジェクトを取得する場合
```ruby
User.find_by(name: "山田太郎")
```
例：email:"hana@samplemail.com"かつname:"高橋花子"であるUserオブジェクトを取得する場合
```ruby
User.find_by(email:"hana@samplemail.com",name: "高橋花子")
```
=> データが複数存在する場合は、最初に一致するデータのみをインスタンス化する。  
   つまり取得するデータは常に1件

#### first
idの一番小さいデータを取得するメソッド  
引数に取得件数を渡すことが可能  
また、second,thirdも可能。  
例：先頭から3件取得する場合
```ruby
User.first(3)
```

#### last
firstの逆

#### take
ランダムにデータを取得するとき  
引数は取得件数を指定可能  
例：ランダムに3件
```ruby
User.take(3)
```

#### all
全件取得

##### all/where と find(複数ID)/find_by_aql によるインスタンスオブジェクトの違い
allやwhereによるインスタンスオブジェクトはActiveRecord::Relationクラス
findのid複数指定によるインスタンスオブジェクトはArrayクラスである
そのため、使えるメソッドが変わってくる。

#### where
テーブルから指定された条件を満たす全データを取得し、インスタンス配列を作るメソッド

#### find_by_sql
データベース操作言語であるSQLを使用してデータを取得したい場合に使用。
Arrayクラスのインスタンスとして配列化。
特別な理由がない限り、ORMの役割を無視して使用するメリットはないので、使用は控える。

### 5.4.4 Update:更新メソッド
#### update
例：id:1のデータのpriceを2500に更新する場合  
- インスタンスメソッド
```ruby
pd = Product.find(1)
pd.update(price: 2500)
```
- クラスメソッド
```ruby
Product.update(1,{price: 2500})
```

#### update_all
指定された属性の値に従って、テーブル上の、モデルに相当するデータの値を全て更新する。  
複数のデータの特定の属性値を一括して初期化するような場合に有効。  
例：全てのデータのpriceを0に更新する場合
```ruby
Product.update_all(price: 0)
```
例：name: cupを満たす全データのpriceを0に更新する場合
```ruby
Product.where(name: "cup").update_all(price: 0)
```

### 5.4.5 Delete:削除メソッド
#### destroy
データをインスタンス化してから削除する。  
update同様クラスメソッドとインスタンスメソッドがある。  
例：id:1のデータを削除する場合
```ruby
# クラスメソッド
User.destroy(1)
# インスタンスメソッド
User.find(1).destroy
```
#### destroy_all
全データ削除

#### delete
データをインスタンス化せずに直接削除できる。  
ただし、コールバックが働かないため、業務処理に適していない。  
インスタンスメソッド、クラスメソッド両方できる。  
例：データを直接削除する場合
```ruby
# インスタンスメソッド
User.find(1).delete
# クラスメソッド
User.delete(1)
```
#### delete_all
全てのデータをインスタンス化せずに直接削除する

#### クラスメソッドとインスタンスメソッドの違い
Bookモデルがある場合の挙動
クラスメソッドはBookモデルのデータ全体に対するメソッドであるため、全てのデータ（インスタンス）に影響がある。
インスタンスメソッドはデータ1件（例えばid:1のもののみ）にしか影響されないということ。

| メソッド | クラスメソッド | インスタンスメソッド |
| ---- | ---- | ---- |
| save | X | O |
| create | O | X |
| update | O | O |
| destroy | O | O |
| delete | O | O |
| update_all | O | X |
| destroy_all | O | X |
| delete_all | O | X |

create/save/updateメソッドは、テーブル操作前にバリデーションを実装できる。  
バリデーション に失敗した場合はロールバックを行い、createはインスタンスを、save/updateはfalseを返す。  
この際、ActiveRecord::RecordInvalid例外エラーを発生させたい時は、!をメソッド名の後ろにつける。  
create!/save!/update!

### 5.4.7 条件による読み出しメソッド(where)
seeds.rb
```ruby
User.create(name:"山田太郎",address:"東京都港区", email:"ta@abc.jp")
User.create(name:"田中花子",address:"東京都港区", email:"hk@abc.jp")
User.create(name:"山崎隆文",address:"東京都品川区", email:"tn@abc.jp")
User.create(name:"佐々一郎",address:"東京都品川区", email:"ic@abc.jp")
User.create(name:"大友裕子",address:"東京都港区", email:"to@abc.jp")
User.create(name:"山田太郎",address:"北海道札幌市", email:"yt@abc.jp")
```

#### 属性値の列where条件を指定する方法
```ruby
モデル名.where(属性名: "条件の値")
# name属性が「山田太郎」と一致するもの
# そのレコードの数
users = User.where(name: "山田太郎")
users.count #=> 1

# addressが東京都港区のものと東京都品川区のもの
users = User.where(address: ["東京都港区","東京都品川区"])
users.count #=> 5

# 上記の条件に追加して、名前が山田太郎であるもの
users = User.where(address: ["東京都港区","東京都品川区"],name:"山田太郎")
users.count #=> 1

# addressが東京都港区か北海道札幌市であり、名前が山田太郎であるもの
users = User.where(address: ["東京都港区","北海道札幌市"],name:"山田太郎")
users.count #=> 2
```

#### where条件を条件式で指定する方法
nameが山田太郎であり、birthdayが1975-02-02より後のものを条件にした例

- 直接指定：条件の値を文字列で直接指定する方式  
  SQLインジェクションという攻撃の対象になるので推奨しない。  
  ```ruby
  User.where('name = "山田太郎" and birthday > "1975-02-02"')
  ```

- 配列指定：条件を「?」で指定して、配列のように?の順に値を指定する方式  
  プレースホルダー形式ともいう。  
  ```ruby
  User.where("name = ? and birthday > ?","山田太郎","1975-02-1")
  ```

- ハッシュ指定（名前つきプレースホルダー形式）：条件をシンボルキーで指定して、ハッシュ脳ようにシンボルに対する値を指定する方式  
  ```ruby
  User.where("name = :k1 and birthday > :k2", k1:"山田太郎",k2:"1975-02-1")
  ```

#### あいまい検索
where条件を条件式で指定する方法が使えれば、あいまい検索が可能となる。  
これまで=だった部分をlikeに変え、値の指定を%を使って表す。  

例：nameに「田」が入っているUserモデルの取得  
配列指定で記述
```ruby
users = User.where("name like ?","%田%")
```
例：birthdayが1975年のUserモデル
```ruby
users = User.where("birthday like ?","1975%")
```

#### where条件の否定の仕方
whereの条件と逆のデータ  
モデル.where.not(条件)  
例：addressに東京が含むUserモデルと含まないUserモデル
```ruby
# Userモデルの全件数取得
User.all.count #=> 6
# 含む
include = User.where("address like ?","東京%")
include.count #=> 5
# 含まない
not_include = User.where.not("address like ?","東京%")
not_include.count #=> 1
```
ただし、検索対象の属性の値がnilの場合除外される。

### 5.4.8 インスタンス配列の取得を支援するメソッド
- select(対象属性)  
テーブルの列単位（属性列）で取得する。  
例：Userモデルの、名前と誕生日のみのインスタンス配列を取得する場合
```ruby
User.select(:name,:birthday)
```
例：distinctで重複する名前を一つにする場合
```ruby
User.select(:name).distinct
```

- limit/offset  
limitは取得データの数を指定できる。  
offsetは取得データの開始位置を指定できる。  
例：4件目から8件目まで取得する場合  
配列と同じで0スタート  
```ruby
User.offset(3).limit(5)
```

- order  
指定された属性の値に従って並び替える。  
昇順(asc)/降順(desc)を指定できる。  
デフォルトは昇順  
例：名前を昇順、年齢を降順に名前・年齢順のユーザーを取得する場合
```ruby
User.order(:name, age: :desc)
```

- group  
指定された属性でグループ化する。  
例：addressでグループ化し、グループごとのデータ数を取得する場合
```ruby
User.group(:address).count
 #=> {"北海道札幌市"=>1, "東京都品川区"=>2, "東京都港区"=>3}
```
QuizTemplateAppにおいて、カテゴリー別に正答率を計算させることも可能だった。
CorrectAnswerRate.group(:category_id).count

- having  
groupメソッドにたいす条件として指定できる。

- unscope/only  
unscopeは上位メソッドのうち指定したものを取り除く  
onlyは上位メソッドのうち指定したもののみを有効にする  

etc...etc....

#### メソッドチェーン
これまでのメソッドはインスタンス配列を返すため、「.」でメソッドをつなげて記述することができる。  
こういった相互に連結したメソッドをメソッドチェーンという。

### 5.4.9 そのほか便利なメソッド
- pluck  
mapを使った記述を簡単にするpluckメソッド  
例：Userモデルの名前とメールアドレスだけの配列を取得する場合
```ruby
User.pluck(:name,:email)
```
- ids  
pluck(:id)と同じ意味を持つidsメソッド

- count  
引数に属性値を指定するとnilも取得してくれる。

- sum  
合計

- average  
平均値  
例：Productモデルについて、priceの平均値を浮動小数点数で取得する場合
```ruby
Product.average(:price).to_f
```

### 練習問題 5.4
1. CRUD操作とは何かを、データリソースとの漢検を使って説明してください。
  - 解答

  - 正解

2. CRUD操作を実現する代表的なメソッドについて、一つのモデルを例に具体的な使い方を説明してください。
  - 解答

  - 正解

3. save,create,updateのメソッドについて、役割、および関係をメソッドの対象となるオブジェクトの種類も含めて説明してください。
  - 解答

  - 正解

4. selectメソッドとfind_byメソッドの違い、およびselectとpluckメソッドの違いを具体的に説明してください。
  - 解答

  - 正解


## 5.5 まとめ