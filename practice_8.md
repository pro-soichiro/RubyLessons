# ルーターとコントローラー
- ルーターとコントローラーはRailsのAction Packコンポーネントのサブコンポーネントにより提供される機能。
- ルーターはAction Dispatch(アクション実行振り分け)
- コントローラーはAction Controller(アクション実行制御)
- ルーターの役割  
  - クライアントからの要求をアクションに割り付けること
- コントローラーの役割  
  - ルーターにより割り付けられた要求の実行を制御する一連の働きを行うこと
## 8.1 ルーティングとは
### 8.1.1 HTTPメソッド
webアプリケーションにおいて、
- URI 要求の宛先
- HTTPメソッド 要求目的
  - GET 情報をサーバーから取得するための要求
  - POST 情報をサーバーに取り込むための要求
  - PUT 情報を置き換えるための要求
  - PATCH 情報の一部を置き換えるための要求
  - DELETE 情報を削除するための要求
#### リソースフルルート
resources :モデル名複数形
7つのアクション
- index 一覧
- show 詳細
- new 新規
- create 登録
- update 更新
- edit 編集
- destroy 削除
> 標準のアクション名をうまく活用することは、Railsの基本理念であるCoC(設定より規約)の一つの大きな要素
> より他の作成作業に集中する
> モデルを介してリソースを処理するルートは、7つのアクション全てを利用する/しないにかかわらず、リソースフルルートに従うこと
> リソースを対象としない機能に従うとしても、全体の概要を表示するなどの処理では、indexアクションを利用することが一般的
> 対象となるリソースが一つの場合、一覧は不要でありindexルートは使わず、resourceルートを使用する
> 結果、index以外のアクションのみ定義されるのがresourceルートである

#### 非リソースフルルート
リソースフルルート以外  
従来通り個別で設定するルートのこと  
HTTPメソッドを指定する必要がある。

### 練習問題 8.1
1. ルートの役割について説明してください。
  - 解答
    ルートはクライアントからのHTTPリクエストに対して適切な処理を実行するためのアクションの振り分けを行う役割がある。
  - 正解
    クライアントからの要求をアクションに割り付けること
  
2. リソースフルルートと個別のルートとの関係と、その違いについて説明してください。
  - 解答
    リソースフルルートは一つの記述で7つのアクションを設定できるため、他の作業に集中できる。
    個別のルートではHTTPメソッドを考え、URI、コントローラー、アクションも考えなければならないため非効率的である。

  - 正解
    リソースフルルートは実装上、個別のルートに展開されるため、ルーティング動作の点で変わりはない。  
    リソースフルルートの設定は、見た目が非常にシンプルであり、複数の個別ルートをリソース型に1文で設定できれば、管理も楽になる。  


## 8.2 ルート設定とルーティングヘルパー
### 8.2.1 ルート設定ファイルと実装ルートの確認方法
- Railsコマンドを使用する方法
  ```bash
  $ rails routes
  ```
- ブラウザーから確認する方法
  URL で /rails/info/routesでできる

### 8.2.2 アプリケーションルート(root)の設定方法
#### アプリケーションルートとは
サーバーに接続した時、最初に表示されるトップページ  
設定されていない場合、Rails標準ページが呼び出される。
> publicディレクトリの中にindex.htmlファイルを配置すると、Rails標準ページの代わりにトップページとして表示させることも可能

#### 設定方法
rootメソッドを使う
```ruby
root to: 'コントローラー名#アクション名'
# 上記の方が明示的に、よりシンプルに表現できる。
# 下記のように記述することも可能
get '/', to: 'コントローラー名#アクション名'
```
#### リダイレクト（再接続要求）とは
要求された宛先で受け取ったルートを、異なる宛先への接続要求を出し直すことで、別のページへ接続させる仕組み

#### アプリケーションルートの設定を使い、リダイレクトを指定する
```ruby
root to: redirect('user/index')
```
> これはコントローラー名とアクション名ではなくURIであることを注意
#### アプリケーションルートの表示ルール
優先順位
1. publicディレクトリにindex.htmlが存在する場合：public/index.htmlを表示する
2. routes.rbにルート設定がされている場合：ルートに従ったページを表示する
3. ルート設定がされていない場合：Railsデフォルトのページを表示する

#### 非リソースフルルートでの設定
```ruby
HTTPメソッド 'URIパターン', to:'コントローラー#アクション'
```
> HTTPメソッドとURIパターンの組み合わせが、to:オプションで指定される「どのコントローラー」の「どのアクション」を呼び出すか表している。
例：`http://ドメイン:ポート番号/login` Authenticationsコントローラーのnewアクション  
```ruby
get '/login', to: 'authentications#new'
```
#### matchメソッドは特別な理由がない限り使わない
従来から、Railsではmatchメソッドを利用したルートの設定方法が用意されてきた。  
今は、特に特別な理由がない限り使用しない。  
もしmatchメソッドを利用する場合は、次のようにviaオプションを使用して、HTTPメソッドを指定する必要がある。  
```ruby
# getのみを指定
match '/login', to: 'authentications#new', via: :get
# get/postのみを指定
match '/notices', to: 'notices#treat', via: [:get,:post]
```
#### 呼び出し先の省略
URIで指定されたパス名が、コントローラーとアクションに相当している場合省略できる。
```ruby
get 'introduction/index'
# 下記と同じ
get 'introduction/index', to: 'introduction#index'
```
#### URIパターンで使用するパラメーター
URIパターンには、リソースの特定などに使用する任意の名前のパラメーターを含むことができ、それらのパラメーターはシンボル形式によって指定する。  
クライアントから受信するデータをパラメーターとして扱い、ルーティングによって呼び出されるコントローターのアクションを通して、paramsオブジェクトのハッシュ形式で受け取ることができる。  
例：ルート
```ruby
get 'introduction/:id',to: 'introduction#show'
```
> クライアントから次のような2種類のURIにアクセス
- http://localhost:4000/introduction/1
- http://localhost:4000/introduction/2
<実行内容>
1. 上記のURIをルートが受け取る
2. 「:id」というパラメーター部分に相当する値が入っているものと認識
3. 上記のルートを採用
4. introduction#showを実行
> パラメーターの値が正しいかどうかは、ルーターでは判断できない。
> ルーターは、そのパターンに一致するURIルートが存在するかどうかをルート定義の上から順にチェックし、一致したと判断したときに、そのルートで指定されているアクションを呼びに行く。
> したがって、`http://localhost:4000/introduction/aaa`のような宛先URIのリクエストがされたときに、ルーターが最初に`introduction/:id`というURIパターンを見つけると、idの値が「aaa」のパターンに一致したと判断するので、ルートの設定順には注意が必要。

#### 上記のルールから考えられること
get ':controller/:action'  
というルートを設定すると  
URI`http://localhost:4000/introduction/index`の場合  
paramsオブジェクトで`params[:controller]`や`params[:action]`のように取得できる  
それぞれが保持する値はintroductionとindex  
> しかし、このようなルートは望ましくない
> paramsオブジェクトでハッシュ形式で取得できる仕組みとだけ知っておく

#### クエリパラメーターを含むURIの扱い
問い合わせや情報検索などのURIで、条件を含んだパラメーターを付加することができる。  
それをクエリパラメーター（条件パラメーター）という。  
例：  
> ルート
```ruby
get 'introduction/show'
```
> リクエスト
```
http://localhost:4000/introduction/show?user_id=5
```
?以降がクエリパラメーター  
showアクションでは`params[:user_id]`を使ってクエリパラメーターを受け取れる。  

#### ルートに設定するパラメーターのワイルドカードについて

- ワイルドカードとは？  
あらかじめ特的できない任意のパターンを一括りで指定するやり方。
例：  
> ルート
```ruby
get '/divisions/*section/:id', to: 'sections#show'
```
> リクエスト
`http://localhost:4000/divisions/some/group11/5`
> 取得方法
```ruby
params[:section]
 => 'some/group11'
params[:id]
 => '5'
```
ただし、ワイルドカード指定は、使い方を間違えるとパラメーターとしてなんでも取り込めてしまうので、使用する際にはセキュリティ面で注意が必要。

### 8.2.4 ルーティングヘルパー
#### ルーティングヘルパーとは？
Railsのルートを設定すると、宛先URLを1語で表現するPathヘルパー（またはURLヘルパー）が自動的に実装される。  
この、宛先URLを1語で表現するための**メソッドをルーティングヘルパー**という。

#### ルーティングヘルパーのメリット
- コントローラーやビューなどRailsアプリケーションの中で、遷移先をわかりやすく簡潔に指示することができる。

#### 確認方法
ルーティング情報のPrefix欄
> プレフィックスとは、接頭辞、前につける、などの意味を持つ英単語。

#### PathヘルパーとURLヘルパー
Prefix欄の単語に`_path`もしくは`_url`をつけることで、それぞれのヘルパーとして使うことができる。
- Pathヘルパーは、アプリケーションルートからの相対パスを簡潔な1語(例：new_user_path)で表現する。
- URLヘルパーは、ドメイン名を含めた完全なURIを簡潔な1語(例：new_user_url)で表現する。

#### ルーティングヘルパーにおけるパラメーターの扱い方
> 引数としてわたす

```ruby
book_path(2)
book_url(2)
```

#### クエリパラメーターの場合のヘルパーの扱い
例1:  
> リクエスト

```
http://localhost:4000/introduction/show?user_id=5
```

の場合  
`introduction_path(user_id: 5)`と記述。  

例2:
> リクエスト

```
http://localhost:4000/books?authcode=22&pubcode=5
```

の場合  
`books_path(authcode: 22,pubcode: 5)`と記述。

#### まとめ

ルーティングヘルパーは、どのようなケースのパラメーターでも、引数として簡単に取り込むことができる。

### 練習問題 8.2
1.ルートにおいて、HTTPメソッドとURIはどのような役割をするのか説明してください。
  - 解答
    URIが要求宛先、HTTPメソッドが要求目的
  - 正解
    正解。付け加えるなら、HTTPメソッドとURIパターンの組み合わせが、to:オプションで指定される「どのコントローラー」の「どのアクション」を呼び出すか表している。

4.Reservationアプリケーションで、`rails routes`コマンドを実行した時に表示されるルートの中で  
「POST /rooms(.:format) rooms#create」に該当するルーティングヘルパーを説明してください。
  - 解答
  Prefixはroomsであり  
  Pathヘルパーは rooms_path(:id)  
  URLヘルパーは rooms_url(:id)  
  - 正解
  正解
5.Reservationアプリケーションで、

```bash
  # 1
  rooms GET /rooms(.:format) rooms#index
  # 2
  room GET/rooms/:id(.:format) rooms#show
```

という2つのルートのルーティングヘルパーの使い方および違いを、  
パラメーターの指定の仕方を含めて説明してください。  
ただし、formatパラメーターについては無視してかまいません。
  - 解答
  違いはprefix名が違うことと、パラメーターの有無です。
  1はパラメーターを持たず、rooms_pathもしくはrooms_urlでヘルパーを使用する。  
  2はパラメーターを持ち、room_path(:id)もしくはroom_url(:id)でヘルパーを使用する。
  - 正解
  正解

## 8.3 リソースフルルートをより有効に使う方法
前提としてリソースフルルートを有効に使い開発を行うことが大切。  
その上でonlyやexceptオプションを使用することで、リソースフルルートを有効に使うことが可能。  
#### 同じデータリソースに対し、標準以外の独自アクションルートを設定したい場合
非リソースフルの単独ルートとして設定することも可能だが、同じリソースのルートとしてリソースフルルートに追加することで、一括管理できるようにするためのオプションがある。  
#### ルートの種類
- **リソースidを特定できるルート = メンバールート**  
  idを特定できる既存のリソース1件に対するルート。  
  show/edit/update/destroy  
  > memberオプションを使用してルートを設定する。

- **リソースidを特定できないルート = コレクションルート（集合ルート）**  
  複数のリソースを対象とするルート。または、idを持っていない新規リソースに対するルート。  
  new/create/index  
  > collectionオプションを使用してルートを設定する。

#### 独自ルートの設定方法
- ブロック（do~end）
- onオプション  
どちらを使ってもいいが、onの方がすっきりと記述できる。

#### 具体的な例から設定方法を確認する
##### 具体例1:Userモデルに検索機能
> 「検索」は"複数リソース"に対して行う処理であるため**コレクションルート**を使用
```ruby
# ブロック
resources :users do
  collection do
    get 'search'
  end
end
# onオプション
resources :users do
  get :search, on: :collection
end
```

##### 具体例2:Userモデルの特定のユーザーの情報をダウンロードする機能
> 特定のユーザー（"単一リソース"）の情報であるため**メンバールート**を使用
```ruby
# ブロック
resources :users do
  member do
    get 'download'
  end
end
# onオプション
resources :users do
  get :download, on: :member
end
```

##### 結果
collectionルートで設定すると:idパラメータはつかないが、memberルートには:idパラメータを持たせることができる。  
メンバールートは、このURIパターンに従った:idパラメーターの値を指示されると、HTTPメソッドとURIに一致したルートに対応するコントローラーのアクションを呼びだす。
#### collection
コレクションルートの設定に使用。  
コレクションルートとはidが特定できないリソース（複数リソース、新規リソース）を対象としたルート。  
リソースフルルートでいう、index、new、createがそれに該当。
#### member
メンバールートの設定に使用。  
メンバールートとはidを特定できる単一リソースを対象にしたルート。  
リソースフルルートでいう、show、edit、update、destroyがそれに該当。

### 8.3.3 親子関係を持つ入れ子ルートについて
#### 使用するケース
> 親子関係にあるリソースに対し、親の特定のリソースに紐づいてルーティングを行う仕組みを持たせる。
  
親子関係を持つモデルで、このモデルのリソースには親を通じてしかアクセスする必要がない場合。  
そのような場合は、ルート上でも制約を設けることで、セキュリティ面や管理面で望ましい。  
また、親リソースと子リソースの関係をルート面で明確にすることで、より理解しやすくもなる。  
例：Questionに対するChoiceモデル  
選択肢に対してのみアクセスすることはないため。  

#### 設定法方
```ruby
# 例：Userモデルとその子モデルHobby(趣味)モデル
resources :users do
  resources :hobbies
end

# 例：Questionに対するChoiceモデル  
resources :questions do
  resources :choices
end
```

ユーザーが自分の子リソースであるHobbyモデルにアクセスするためには、`/users/:user_id/hobbies/:id`のように、自分を特定するユーザーIDと、該当する趣味のIDの両方のID値を指定しないとアクセスできなくなる。
#### しかし！！
実際は、上記のような場合であっても、Hobbyモデルのidはユニークなので、Hobbyモデルのidがわかれば自ずとアソシエーションで紐づいているUserのidもわかる。  
子のIDが必須なメンバールートの場合は、子のIDだけのURIでアクセスすることができる。  
このようなルートの使い方を、**shallowルート（浅いルート）**という。

#### shallowルートの設定方法

- ブロックを使う場合

```ruby
# 例：Userモデルとその子モデルHobby(趣味)モデル
shallow do
  resources :users do
    resources :hobbies
  end
end
# 例：Questionに対するChoiceモデル  
shallow do
  resources :questions do
    resources :choices
  end
end
```

- ブロック以外の設定方法

```ruby
# 例：Userモデルとその子モデルHobby(趣味)モデル
resources :users, shallow: true do
  resources :hobbies
end
---
resources :users do
  resources :hobbies, shallow: true
end
```

上記のコードはどちらでもルートに対して変わりはなく、同じものとなる。

#### 1階層化されたshallowルートのURIのPrefixの変更
例：
```ruby
resources :users do
  resources :hobbies, shallow: true, shallow_path: 'people', shallow_prefix: 'person'
end
```

### ルートの比較
- 単純な入れ子

```bash
                   Prefix Verb   URI Pattern                                  Controller#Action
             user_hobbies GET    /users/:user_id/hobbies(.:format)            hobbies#index
                          POST   /users/:user_id/hobbies(.:format)            hobbies#create
           new_user_hobby GET    /users/:user_id/hobbies/new(.:format)        hobbies#new
          edit_user_hobby GET    /users/:user_id/hobbies/:id/edit(.:format)   hobbies#edit
               user_hobby GET    /users/:user_id/hobbies/:id(.:format)        hobbies#show
                          PATCH  /users/:user_id/hobbies/:id(.:format)        hobbies#update
                          PUT    /users/:user_id/hobbies/:id(.:format)        hobbies#update
                          DELETE /users/:user_id/hobbies/:id(.:format)        hobbies#destroy
                    users GET    /users(.:format)                             users#index
                          POST   /users(.:format)                             users#create
                 new_user GET    /users/new(.:format)                         users#new
                edit_user GET    /users/:id/edit(.:format)                    users#edit
                     user GET    /users/:id(.:format)                         users#show
                          PATCH  /users/:id(.:format)                         users#update
                          PUT    /users/:id(.:format)                         users#update
                          DELETE /users/:id(.:format)                         users#destroy
```

- shallowを使用し、1階層化した入れ子

```bash
                   Prefix Verb   URI Pattern                                  Controller#Action
             user_hobbies GET    /users/:user_id/hobbies(.:format)            hobbies#index
                          POST   /users/:user_id/hobbies(.:format)            hobbies#create
           new_user_hobby GET    /users/:user_id/hobbies/new(.:format)        hobbies#new
               edit_hobby GET    /hobbies/:id/edit(.:format)                  hobbies#edit
                    hobby GET    /hobbies/:id(.:format)                       hobbies#show
                          PATCH  /hobbies/:id(.:format)                       hobbies#update
                          PUT    /hobbies/:id(.:format)                       hobbies#update
                          DELETE /hobbies/:id(.:format)                       hobbies#destroy
                    users GET    /users(.:format)                             users#index
                          POST   /users(.:format)                             users#create
                 new_user GET    /users/new(.:format)                         users#new
                edit_user GET    /users/:id/edit(.:format)                    users#edit
                     user GET    /users/:id(.:format)                         users#show
                          PATCH  /users/:id(.:format)                         users#update
                          PUT    /users/:id(.:format)                         users#update
                          DELETE /users/:id(.:format)                         users#destroy
```

- 1階層化したあとprefixとURIを変更

```bash
                   Prefix Verb   URI Pattern                                  Controller#Action
             user_hobbies GET    /users/:user_id/hobbies(.:format)            hobbies#index
                          POST   /users/:user_id/hobbies(.:format)            hobbies#create
           new_user_hobby GET    /users/:user_id/hobbies/new(.:format)        hobbies#new
        edit_person_hobby GET    /people/hobbies/:id/edit(.:format)           hobbies#edit
             person_hobby GET    /people/hobbies/:id(.:format)                hobbies#show
                          PATCH  /people/hobbies/:id(.:format)                hobbies#update
                          PUT    /people/hobbies/:id(.:format)                hobbies#update
                          DELETE /people/hobbies/:id(.:format)                hobbies#destroy
                    users GET    /users(.:format)                             users#index
                          POST   /users(.:format)                             users#create
                 new_user GET    /users/new(.:format)                         users#new
                edit_user GET    /users/:id/edit(.:format)                    users#edit
                     user GET    /users/:id(.:format)                         users#show
                          PATCH  /users/:id(.:format)                         users#update
                          PUT    /users/:id(.:format)                         users#update
                          DELETE /users/:id(.:format)                         users#destroy
```

#### shallow
親子関係を持つ入れこのルートに対して、直接、子のidだけでアクセスできるようにshallowルート（浅いルート）表現に変更する。
#### shallow_path
指定されたパス名を、入れ子のshallowルートのURLの前に付加する。
#### shallow_prefix
指定されたプレフィックス名を、入れ子のshallowルーティングヘルパーの接頭辞に付加する。

### リソースフルルートのグループ化
親子関係のルートに限らず、関係する機能を持ったものであれば、複数のリソースフルルートをグループ化することができる。

#### 何ができるのか？
共通のグループ名のもとに、関係するルートおよびリソースを管理することができる。

#### 具体的にどうやるのか？
2種類ある。  
QuizTemplateApp作成時にもadminとpublicを分けるために、adminにnamespace、publicにscopeを使用していた。  
違いを見ていく。  

- 名前空間（namespace）  
ルートを含めた一連のリソースに対してグループ化する場合。  

- スコープ（scope）  
ルートだけ/リソースだけといったように目的に合わせてグループ化する場合。  



## 8.4 コントローラーの役割
