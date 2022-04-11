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

  ### アソシエーションメソッドのオプション

  - class_name  
    アソシエーションのメソッド名をモデルと異なる名前で利用したい場合に、実際のモデル名を対応つけるオプション。
  - dependent  
    親子関係のあるモデルで、親モデルのデータリソースを削除する場合、それと紐つく子モデルのデータリソースをどう扱うかを指定する。  
    親を削除すると紐付く子も削除される。  
    ```ruby
    has_many :rentals, dependent: :destroy
    ```
    - :destroy  
      子のデータリソースがある場合にこのデータリソースも同時に削除される。
    - :restrict_with_error  
      子のデータリソースがある場合に親のインスタンスにエラーを通知する。
    - :restrict_with_exception  
      子のデータリソースがある場合に例外エラーを発生する。

  - foreign_key  
    子モデルに設定する親モデルの外部キー名を、指定のものにしたい時。（デフォルトは「親モデル名_id」）  
    例：子モデルHobbyの外部キーをperson_idとして設定する  
    has_many :hobbies, foreign_key: "person_id"  

  - autosave  
    親モデルのアソシエーションメソッド（has_many）に対してautosaveをtrueにすることで、親インスタンスを保存した時、その時点で紐づいている新規の子インスタンスも全て保存される。

  > ビューの章で扱う`accepts_nested_attributes_for`を使用する場合、親モデルのautosaveオプションはtrueになっている必要がある。

  - validate  
  アソシエーション設定している親子モデルにおいて、バリデーションも併せて実行するか、しないかを設定する。   
  trueの場合、関係モデルのインスタンスも合わせてバリデーション を実行し、falseの場合は、関係モデルのインスタンスは無視する。

  ### 7.1.5 単一テーブル継承(STI)などのモデルの応用関係
  #### 何ができるか？
  単一テーブル継承を利用すると、同じような情報を持つ目的別の複数モデルを1つのテーブルだけで対応させることができる。
  #### 例
  ペットを管理するペットモデルとそれを継承する犬と猫モデルがある時、データベースのテーブルはPetモデルにだけ紐ついており、dog,catそれぞれはpetsテーブルの中で管理される。
  #### 具体的な使用例
  1. 異なるユーザー種類を管理する場合
  2. 異なる種類のコードや情報を同じ形式で管理したい場合

  - ポリモーフィックな関係  
  共通のbelongs_toメソッドを使用して複数の親モデルに関係つけること  
  親モデル名_idの追加の必要性をなくす仕組み  
  ```bash
  $ rails g model picture imageable:references{polymorphic} path_name:string
  ```
  親モデルでは`has_many :pictures, as: :imageable`と記載する

  ### 7.1.6 モデル結合を利用したインスタンス配列の取得
  #### モデル結合とは？
  関係する複数モデルのデータリソースを、まるで一つのモデルデータリソースのように取り扱う方法のこと。
  #### メリット
  複数のデータリソースに対応するそれぞれのテーブルをまとめて一つの一時的な仮想テーブルにすることで、検索処理などを効果的に行うことができる。

  #### 左外部結合(left outer join)
  結合メソッドを呼び出したインスタンスのテーブルのデータを基準にして、相手側のテーブルの外部キーidで紐つくデータのみ結合する方法

  #### 内部結合(inner join)
  お互いに内部キーで紐つくidの一致するデータリソースだけを結合する方法

  #### 左外部結合と内部結合の違い
  左外部結合はnilもレコードが作られるが、内部結合はidが一致したもののみレコードが作成される。

  #### N+1問題
  テーブルに対するn件のデータ検索を行う場合に、n+1件のSQL検索命令が発行されることにより、処理速度が大幅に悪化する状況を指す。

  #### includesメソッド
  何もせずに、記述する場合
  ```ruby
  2.6.3 :029 > Rental.all.each { |d| puts d.book.title }

    Rental Load (0.1ms)  SELECT "rentals".* FROM "rentals"
    Book Load (0.1ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 5], ["LIMIT", 1]]
    Railsの夜明け
    Book Load (0.1ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
    小説Rubyの冒険
    Book Load (0.1ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
    タイトル
  => [#<Rental id: 1, user_id: 26, book_id: 5, rental_date: nil, created_at: "2022-04-08 13:27:12", updated_at: "2022-04-08 13:27:12">,
      #<Rental id: 2, user_id: 26, book_id: 6, rental_date: nil, created_at: "2022-04-08 13:29:26", updated_at: "2022-04-08 13:29:26">,
      #<Rental id: 3, user_id: 15, book_id: 1, rental_date: "2022-04-11", created_at: "2022-04-11 09:35:53", updated_at: "2022-04-11 09:37:23">]
  ```
  includesメソッドを使用し、N+1問題の対策をした場合
  ```ruby
  2.6.3 :030 > Rental.includes(:book).all.each { |d| puts d.book.title }

    Rental Load (0.1ms)  SELECT "rentals".* FROM "rentals"
    Book Load (0.2ms)  SELECT "books".* FROM "books" WHERE "books"."id" IN (?, ?, ?)  [["id", 5], ["id", 6], ["id", 1]]
    Railsの夜明け
    小説Rubyの冒険
    タイトル
  => [#<Rental id: 1, user_id: 26, book_id: 5, rental_date: nil, created_at: "2022-04-08 13:27:12", updated_at: "2022-04-08 13:27:12">,
      #<Rental id: 2, user_id: 26, book_id: 6, rental_date: nil, created_at: "2022-04-08 13:29:26", updated_at: "2022-04-08 13:29:26">,
      #<Rental id: 3, user_id: 15, book_id: 1, rental_date: "2022-04-11", created_at: "2022-04-11 09:35:53", updated_at: "2022-04-11 09:37:23">]
  ```

### 練習問題 7.1
1. アソシエーションとは何かを説明し、どのようなアソシエーションの関係があるかをピックアップしてください。
  - 解答
    - アソシエーションとはモデルとモデルの関係を紐付けて、データリソースの管理をしやすくすることである。
    - 具体的な関係には、「1対多」「1対1」「多対多」がある。
  - 正解
    - 
2. アソシエーションを設定する基本の3つのメソッドについて、具体的なモデルで相互の設定方法を説明してください。
  - 解答
    - `has_many``belongs_to``has_one`が基本の3つ。
    - 例えば、部活動(Club)を表すモデルがあり、それに属する生徒(Student)がいるとするとした時。部活動モデルには`has_many :students`と追記し、生徒モデルには`belongs_to :club`と記述する。
    - また生徒(student)の所属する家族(family)モデルがあった場合、1対1の関係となり、生徒モデルには`has_one :family`と記述し、家族モデルには、`has_one :student`と記述する。
  - 正解
    - 
3. 親子モデルのアソシエーションで、外部キーの役割と標準の設定ルールについて説明してください。
  - 解答
    - 外部キーはアソシエーションにおいて、繋がりを識別するために所持させている。
    - 標準の設定ルールとしては、`親モデル名_id`で子モデルの属性にinteger型で親モデルのindex_idを持たせることである。
  - 正解
    - 
4. 多対多の関係を作る2つの方法をそれぞれ具体的に説明してください。
  - 解答
    - hmt型
      - `has_many :子モデル名複数 , through: 中間モデル名`
      - データベースのモデルを持つ
    - habtm型
      - `has_and_belongs_to_many :中間テーブル名`
      - データベースには情報はない。
  - 正解
    - 
5. 単一テーブル継承の目的、およびテーブルと関係付ける方法について説明してください。
  - 解答
    - 単一テーブル継承の目的は、一つのテーブルで複数のモデルを管理すること
    - テーブルと関連付けるには、エディターでモデルを作成し、データベースに紐づいているモデルのクラスを継承させる。
    - データベースに紐づいているモデルのクラスではtype属性をstringタイプで定義する必要がある。
  - 正解
    - 
6. N+1問題は、どのようなケースで発生するか、対処方法を含めて具体的に説明してください。
  - 解答
    - N+1問題は、10万件などの大量のデータを取得する際に大量のSQL文を発行することで悪化する影響がでてしまうことである。
    - 対策としては、includesメソッドなどを用いてSQL発行数を減らすこと。
  - 正解
    - 


## 7.2 仮想的な属性（attributes API）


## 7.3 タイプオブジェクト

