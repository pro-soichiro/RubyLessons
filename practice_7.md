# 7 モデルを豊かにする仕組み
## 7.1 モデルの関係（アソシエーション）
### 正規化とは？
共通する重複する情報などをデータベースに分離すること。
### アソシエーションとは？
正規化を実現するために紐づける仕組み。
### モデル間の関係
- 1対多 (has_many)
  - 1年A組に属する生徒Aの関係
- 1対1 (has_one)
  - 生徒Aの家庭状況モデル
- 所属関係 (belongs_to)
  - 生徒Aが1年A組に属している
- 多対多
  - 1年A組モデルと部活モデル

```ruby
# class_roomモデルに記述
has_many :students
# studentモデルに記載
belongs_to :class_room
has_one :family
# 家庭状況モデル
belongs_to :student
```
### アソシエーションの定義で何ができるようになるのか？
内部的には相手モデルのインスタンスを参照するインスタンスメソッドになる。  
したがって、設定したモデルのインスタンスから呼び出し、実行することができる。

### 親子を紐付ける外部キーの設定方法
2種類ある。
- 親モデル名_idという属性を整数型として指定する方法
- 親モデル名という属性を参照型（references）で定義する方法
  - 小モデル側にbelongs_toのアソシエーションを自動的に生成してくれる

### アソシエーションの具体例
親モデル=>Landlord  
子モデル=>Borrower  
があるとき、Borrower生成時に以下のような指定を行う  
- `landlord_id:integer`  
- `landlord:references`(`landlord:belongs_to`)  

> managementリポジトリに記載

### 多対多の関係
親モデル同士の関係  
QuizTemplateAppでいうQuestionモデルとStaffモデルの関係  
解答状況モデルとして仲介モデルが必要になる。  

また、Libraryアプリケーションでいう、図書館の図書と、利用するユーザーとの関係モデルでも、貸し出し台帳モデルが必要となる。
貸し出し台帳モデルの所属は図書とユーザーそれぞれに対しては1対多となっており、一つの本に対して複数の貸し出し台帳モデルがあり、1人のユーザーに対して複数の貸し出し台帳モデルがある構図である。

実装方法は2種類
- hmt型 (has_many_throughメソッドの使用)
  1. 中間モデルをそれぞれのモデル名で属性を作りrefarences型で定義する
  2. それぞれのモデルで`has_many :中間モデル名`と`has_many :対モデル名, through: :中間モデル名`を定義
  3. マイグレーション
  4. Userの作成とレンタル情報の確認
  ```ruby
  > user = User.create(name: "山田花子",email:"hanako@sample.com")
  > user.books
    => #<ActiveRecord::Associations::CollectionProxy []> 
    #まだレンタルしているBookモデルがない状態
  ```
  5. Bookの作成とuser(山田花子)への追加
  ```ruby
  > book = Book.create(title: "Railsの夜明け")

  # userのレンタルしている本を追加する
  > user.books << book
    => #<ActiveRecord::Associations::CollectionProxy [#本の情報] 
  ```
  6. もう一冊登録して、User(山田花子)で借りる
  ```ruby
  > book = Book.create(title: "小説Rubyの冒険")
  > user.books << book
  ```
  7. ユーザーが借りている本のタイトルを取得する
  ```ruby
  > hanako = User.find_by(name: "山田花子")
  > hanako.books.pluck(:title)
   => ["Railsの夜明け", "小説Rubyの冒険"]
  ```
  8. 今度は逆に本が誰に借りられているかを取得する
  ```ruby
  > book = Book.find_by(title: "小説Rubyの冒険")
  > book.users.pluck(:name)
   => ["山田花子"]
  ```

- habtm型 (has_and_belongs_to_manyメソッドの使用)
  中間テーブルを用いて、外部キーのみ保持させる。  
  モデルを作成する必要はなく、マイグレーションファイルのみ使用する。
  テーブル名は、結合する双方のモデル名をアルファベット順に_で区切ったもの  
  例：BookモデルとUserモデルなら => books_users
  
  下記の例はmanagementアプリケーションでmemberがcircleに所属することを想定したアソシエーション  
  circleは複数所属可能  
  1. モデルに`has_and_belongs_to_many :対象モデル名`で定義する
  2. マイグレーションファイルを上記のルールに従って作成し、hmt型と同様に属性はモデル名とreferences型で定義する。
  3. マイグレーションをする
  4.  Rails Consoleで確認
    ```ruby
    > member = Member.first
    > member.circle
     => #<ActiveRecord::Associations::CollectionProxy []> 
    > circle = Circle.create(name:"ボードゲーム")
    > member.circles << circle
     => #<ActiveRecord::Associations::CollectionProxy [#<Circle id: 1, name: "ボードゲーム", created_at: "2022-04-08 14:15:39", updated_at: "2022-04-08 14:15:39">]> 
    ```
    これ以降はhmtと同じことができなかった。  
    hmt型を基本的に使うようにする。



## 7.2 仮想的な属性（attributes API）


## 7.3 タイプオブジェクト

