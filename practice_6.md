# モデルに実装すべき役割
## バリデーション
- オブジェクト.errors.any?  
返り値が真偽値なので、scaffoldでは条件分岐に使い、文章中でcountとfull_messagesメソッドを使用して表示している。
```ruby
if オブジェクト.errors.eny?
  オブジェクト.errors.count
  オブジェクト.errors.full_messages.each do | message |
    message
  end
end
```

### 練習問題 6.1
1. バリデーションの目的は何か、またバリデーションはどこに実装すべきかを説明してください。
  - 解答
    正しいデータがデータベースに保存されることを保証するための確認システム。バリデーションはデータリソースに関する確認であるため、モデルの役割であり、モデルに記載する。
  - 正解
    ほぼほぼ正解。画面フォームなどから入力されたデータが妥当かどうかを評価し、適正なデータだけをデータベースに取り込むための機能。
  
2. バリデーション の実装の種類、実装方法について説明してください。
  - 解答
    モデルの作成時にデータベース自体に設定する方法とvalidatesメソッドを使用してモデルに設定する方法がある。
    データベースに設定する場合 email:string:uniqなどのように作成する。
    モデルに設定する場合 validates :email uniqueness: trueのように設定する。
  - 正解
    [ 実装の種類 ]  
    大きく分けると、  
    - 標準のバリデーションヘルパーを利用する方法
    - 独自のバリデーションヘルパーを利用する方法（カスタムバリデーション）
    の2つがある。  

    カスタムバリデーションにも種類があり、
    - モデル内でメソッドを設定する方法
    - validatorクラスを使用して作成する方法

    [ 実装方法 ]
    - 標準のバリデーションヘルパーを使用してvalidatorメソッドで実装する方法
    - モデル内に独自メソッドを設定し、validateメソッドで実装する方法
    - 独自Validatorクラスを使用する方法
  

  
3. フォームオブジェクトはどのような目的で使用するのか説明し、バリデーション機能を使用するためのActiveModelコンポーネントの具体的な実装方法を説明してください。
  - 解答
    フォームオブジェクトはユーザーから情報を受け取るときに使用する。
  - 正解
    フォームオブジェクトの説明については正しい。
    バリデーションにおけるフォームオブジェクトの使用目的については以下。
    - 特定のモデルに限定されない
    - データベースの登録に直接関係がない入力

    例:利用許諾のチェックボックス  

    フォームオブジェクトはモデルと区別して管理するため、app/formsディレクトリに配置する。  
    フォームオブジェクトはActiveModel::Modelをインクルードすることでバリデーション機能を実装できる。  
    バリデーション の対象となる入力項目をattr_accessorメソッドを使用して設定する。  

    ##### app/forms/フォームオブジェクト名.rb
    ```ruby
    class フォームオブジェクト名
      include ActiveModel::Model
      attr_accessor :バリデーションの対象

      validates :バリデーションの対象, バリデーションヘルパーメソッド

    end
    ```

## コールバック

### コールバックとは
モデルオブジェクトのライフサイクル（検証・登録・更新・削除）のタイミングで、あらかじめ用意した特定の処理を呼び出し、実行させる機能。  
callbackとrollbackは違う。  
例：モデルの属性として入力された名前を検証しやすい形式にと整えるメソッドをバリデーションの前に実行させたい時などに使用。  

コールバックは一つのモデルインスタンス内部だけで使用するため、プライベートメソッドとして実装する。

- バリデーションの前に指定したメソッドをコールバックする。  
before_validation
- バリデーションの後に指定したメソッドをコールバックする。  
after_validation
- save/update/create/destroyをいずれかのタイミングで指定したメソッドをコールバックする。  
前  
before_xxx  
前後  
around_xxx  
どの位置でxxxメソッドを実行するか示す必要があるため、yieldの指定が必須  
後  
after_xxx  

>> messageアプリケーションで確認する

### そのほかの特別なコールバック
- after_initialize  
  インスタンス化の後  
- after_find  
  取得の後  
- after_touch  
  touchの後  
- after_create_commit/after_update_commit/after_destroy_commit  
  データベース変更のコミット完了時  
- after_rollback  
  エラー発生時に呼び出されるロールバックが完了したときに指定されたメソッドをコールバックする  

### 6.2.4 コールバッククラスによる共通化
バリデーションと同じように各モデル共通のコールバックメソッドを作ることもできる。  
複雑なコールバック処理の場合、コールバッククラスを使用することで、モデルクラスをシンプルにすることができる。  
> app/callbacks/message_out.rb
```ruby
class MessageOut
  def self.before_validation(obj)
    puts "#{obj.model_name}バリデーション前メッセージ！！"
  end

  def self.before_save(obj)
    puts "#{obj.model_name}保存前メッセージ！！"
  end
end
```

### 6.2 練習問題
1. コールバックとは何かを説明し、コールバックがモデルの中でどのような役割を果たすか説明してください。
  - 解答
    コールバックとは、データリソースのライフサイクルのタイミングにおいて、あらかじめ決めておくことで発生させるメソッド
  - 正解
    モデルオブジェクトのライフサイクルの検証・作成・保存・更新・削除のイベントタイミングで、あらかじめ用意した特定の処理を呼び出し、実行させる機能。

2. コールバックの種類と、それぞれの実行の優先順位について説明してください。
  - 解答
    コールバックの種類は、バリデーションのタイミングで起こるものとsave,update,destroy,createの前後もしくは両方で起こすものがある。

  - 正解
    validation
    - before_validation 実行前
    - after_validation 実行後
    xxxメソッド(save/update/create/destroy)
    - before_xxx 実行前
    - around_xxx 実行前後
    - after_xxx 実行後

    バリデーション=> save => around save => create => around cerate => データの処理
    saveとaround saveではsaveの方が優先順位が高い
    saveとcreateではsaveの方が優先順位が高い

    validate => save => around save => update => around update
    saveとupdateではsaveの方が優先順位が高い  

    その他のコールバック  
    - after_initialize/after_find インスタンス化/取得
    - after_touch
    - after_create_commit/after_update_commit/after_destroy_commit コミット終了時
    - after_rollback エラー発生時ロールバック後

## スコープ
### スコープとは？
モデルのデータリソースの検索に便利な機能。
### 何ができるのか？
モデルに対して、よく利用する検索条件をあらかじめ用意し、それをメソッドとして簡単に利用できる
### 例えば？
Userモデルに身長がheight属性で定義されており、170cm以上のUserのみインスタンス化したい場合。
```ruby
User.where("height >= ?", "170")

# これをscopeを使ってメソッドにすると
# モデルで定義
scope :target_area, -> { where("height >= ?","170") }

# コントローラーなどで
User.target_area
#=> 上記の条件に従ってデータが取得される。
```
### どこに実装するか？
scopeメソッドを使用して、対象のモデルクラスに実装する
### スコープの種類
引数ありと引数なしの二通り。
```ruby
class モデル名 < ApplicationRecord
  # 引数なし
  scope :メソッド名, -> { 検索条件 }
  # 引数あり
  scope :メソッド名, ->(引数) { 検索条件 }
end
```
引数ありにすることで多態的な機能を実装できる。  
具体的には、  
Userモデルに身長がheight属性で定義されており、170cm以上のUserのみインスタンス化したい場合。  
を  
Userモデルに身長がheight属性で定義されており、Xcm以上のUserのみインスタンス化したい場合。  
と言うふうに都度カスタム可能  
下記コードが引数ありのscope  
```ruby
class User < ApplicationRecord
  scope :target_area, ->(x) { where("height >= ?",x) }
end

# コントローラーなどで
User.target_area(170) # 170以上
User.target_area(100) # 100以上
```

### スコープの組み合わせ
メソッドチェーンとして結合することで、複数の条件検索も可能。  
例：Userで性別がmanで身長が170cm以上で年齢が25歳以上の人  
```ruby
class User < ApplicationRecord
  scope :target_gender, ->(gender_arg) { where(gender: gender_arg ) }
  scope :target_height, ->(height_arg) { where("height >= ?",height_arg) }
  scope :target_age, ->(age_arg) { where("age >= ?",age_arg) }
end

# コントローラーなどで
User.target_gender("man").target_height(170).target_age(25)
```

### デフォルトスコープ
上記の例を続けて、未成年はallで呼び出せないようにする。
```ruby
class User < ApplicationRecord
  default_scope { where("age < 20") }
end

# コントローラーなどでデフォルトスコープで呼び出す
User.all
# デフォルトスコープを一時的に無視して全て呼び出したい時
User.unscoped.all
```
デフォルトスコープは他のスコープより先に評価される。

### 練習問題 6.3
1. スコープの役割と設定場所について説明してください。
  - 解答
  
  - 正解

2. 複数のスコープを組み合わせる方法について説明してください。
  - 解答
  
  - 正解
  
3. デフォルトスコープがどのような場合に有効化、例をあげて説明してください。また、デフォルトスコープを無視する検索方法を説明してください。
  - 解答
  
  - 正解

## ロック機能