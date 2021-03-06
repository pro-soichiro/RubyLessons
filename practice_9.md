# 9 コントローラーによるデータの扱い
## 9.1 コントローラーとデータの入出力
### 学習前 練習問題
1.コントローラーが扱うパラメーターの役割を説明し、どのようなものがあるかを具体的に説明してください。  
  ステートレスな環境において、データを保持させる役割。

2.アクションがHTTPレスポンスを返すときに、通常実行する機能について説明してください。  
  render。ビューテンプレートを返す。

3.renderとredirect_toの共通の役割と違いについて説明してください。  
  次につなげることが共通の役割。違いはrenderはビューテンプレートの表示であって、HTTPレスポンスとして終了するが、redirect_toはHTTPリクエストはシド発行する。

4.ストロングパラメーター化は、どういう目的で行うものなのかを説明してください。  
  わからない。

7.Reservationアプリケーションのroomsコントローラーのindex/new/show/editなどのアクションの中に、renderメソッドが定義されていないにも関わらずビューテンプレートが正しく呼ばれ、出力される理由を説明してください。  
  ActionController::Baseで定義されているため、それらはそのクラスを継承している各コントローラーであるから。

8.ステートレスな通信とセッション情報の役割を説明してください。  
  セッション情報の役割はステートレスな通信において、データを保持させる役割がある。

9.セッション情報はどのように使用するものなのかを説明してください。  
  ログインしているユーザーの情報を保持させたりする。4KBまで。

10.セッション情報とクッキーの関係を説明してください。  
  わかりません。

### コントローラーが扱うパラメーター
- フォームパラメーター:request_parameters  
  - 入力データ
- ルートパラメーター:path_parameters  
  - URIに埋め込まれる:idなどの情報
- クエリパラメーター:query_parameters  
  - 問い合わせなどにしようされるURIの?以降のage=24などの(パラメーター＝値)情報

### ストロングパラメーターの役割
マスアサインメントというセキュリティの脆弱性を回避するための手段  
マスアサインメントとは、クライアントから受け取ったparamsハッシュのフォームパラメーターをそのまま一括指定して、受け取ったデータのモデルオブジェクトを自動で生成する機能。  
便利だが、不正な属性などがあるとそのまま取り込まれてしまうため、ストロングパラメーター化する必要がある。  

### ストロングパラメーター化とは？
マスアサインメントを防ぐため、データの保存処理などを行う前に、保存の対象となる属性値を含むパラメーターに対して許可処理を行うこと。  
そうすることによって、ホワイトリスト上にないパラメーターを無視させることができる。  

### ストロングパラメーター化の方法

paramsハッシュのrequireメソッドとpermitメソッドを組み合わせて行う。

- requireメソッド：対象パラメーターグループの要求  
- permitメソッド：個々のパラメーターの許可を与えるホワイトリストの指定  
  
### renderメソッドについて
指定されたルールに基づいて対応するビューテンプレートを呼び出し、それをもとに、アクション内で指示されたインスタンス変数の値などを使ってHTMLを生成する。  
1回のアクション処理の実行において、renderメソッドは1回だけ実行される。(複数の場合 AbstractController::DoubleRenderError例外)  

renderは「newアクションに相当するビューを実行する」という意味であり、「newアクションを実行する」という意味ではない。

### レンダリング
ビューの出力を支持する作業。

### renderなし
Railsは明示的に記述しなくても、アクション名に相当するビューテンプレート（erbファイル）を探し出し、そのrenderメソッドを暗黙的に実行する。  
アクションと異なる名前のビューをレンダリングしたい場合は、renderの引数として、ビューの名前を指示する。

### renderメソッドのオプション
- :action(省略可)
  - 役割  
    - 同じコントローラーないの他のアクションのテンプレートを出力する場合に指定する
  - 例  
    - `render action: :index`
    もしくは  
    - `render :index`

- :template(省略可)
  - 役割  
    - 異なるコントローラーのディレクトリ下のテンプレートを指定して出力する
  - 例  
    - `render template: 'users/index'`
    もしくは  
    - `render 'users/index'`

### ビューテンプレートを使用しない
- ビューデザインに基づくテンプレートまでは必要としない
- 簡単に結果を送信したい
- 動的に構成したビューを出力したい

> renderメソッドの、plain/html/inlineの3種のオプションを使う

### redirect_toメソッド
コントローラーのアクション内で使用する、アクション実行後に他のルートへリダイレクトを行うためのメソッド

### redirect_toのオプション
- notice:メッセージ  
  通知メッセージ
- alert:メッセージ  
  警告メッセージ
- flash:{キー:値}  
  任意のハッシュパラメーターを使って、値をわたす。  
  flash: {alert: message}  
   => <%= flash[alert] %>  
  より簡略化してか記述できるのがnoticeやalert

### セッション情報の制御とクッキーの利用

Webアプリケーションはステートレスである。  
ステートフルにするための仕組みがセッション。  
- 使用  
`session[:キー] = 値`  
- 削除  
`session[:キー] = nil`もしくは`session.delete(:キー)`

### セッション情報の保存場所
保存場所を**セッションストア**という。  
セッション情報はデフォルトではクッキーに保存される。  
クッキーとは、クライアントのWebブラウザーと簡単な情報をやり取りするためのファイル  

> セッションストアは3種類指定できる

- クッキーストア  クライアントのWebブラウザー内のメモリ
- キャッシュストア  サーバーのキャッシュメモリ
- Active Recordストア  データベースのsessionテーブル

> デフォルトはクッキーストア。他にもサーバーのキャッシュメモリやデータベースのsessionテーブルに作成させる方法もあるが、それぞれ手動で設定が必要。

### セッションストアの違いによる管理
デフォルトでは、IDと暗号化されたデータがクッキーに保存される。
キャッシュストアとActiveRecordストアではセッションIDのみがクッキーに保存され、データ自体はそれぞれの空間にある。

### 学習後 練習問題
1.コントローラーが扱うパラメーターの役割を説明し、どのようなものがあるかを具体的に説明してください。  
  - 解答  
    パラメーターの役割は、入力情報をハッシュ形式で受け取る箱の役割。  
    リクエストパラメーター、パスパラメーター、クエリパラメーターの3種類  
    リクエストパラメーターは、クライアントからの入力からのパラメーター  
    パスパラメーターは、URIの:idなどのメンバールートを特定するためのパラメーター  
    クエリパラメーターは、お問い合わせなどでしようされるURIの?以降のパラメーター=値で表示されるパラメーター  

  - 正解  
    パラメーターには、外部からの情報を取り込む目的がある。  
    フォームパラメーターとルートパラメーターとクエリパラメーターがある。  
    フォームパラメーターは、画面の入力フォームから送信されるデータ。  
    ルートパラメーターは、URIの一部として、ルートに埋め込まれるデータ。  
    クエリパラメーターは、URIの?以降で指定される、問い合わせなどに使用されるデータ。  

2.アクションがHTTPレスポンスを返すときに、通常実行する機能について説明してください。  
  - 解答  
    renderメソッドでアクション名に相当するビューテンプレートを返す。

  - 正解  
    アクションで処理した内容を、renderメソッドによって呼び出されたビューテンプレートに埋め込み、HTMLに変換して出力する。

3.renderとredirect_toの共通の役割と違いについて説明してください。  
  - 解答  
    共通の役割は、HTTPレスポンスを返すということ。  
    違いは、renderは返すビューテンプレートを指定するメソッドで、redirect_toメソッドはHTTPリクエストを再度発行するメソッドである。  

  - 正解  
    ほぼほぼ正解。  
    redirect_toは、アクション実行後に他のルートへリダイレクトを行うためのメソッド。  

4.ストロングパラメーター化は、どういう目的で行うものなのかを説明してください。  
  - 解答  
    ストロングパラメーター化とは、ハッシュで受け取った情報を一括で保存させると間違った情報や悪意のある情報が紛れ込む恐れがあるため、許可する属性値を設定して、それに適用される情報のみをキャ化するようにすること。
  - 正解  
    許可処理を経由しないパラメーターを無効にする仕組み。  
    クライアントから受け取ったparamsハッシュのフォームパラメーターをそのまま一括指定して、受け取ったデータのモデルオブジェクトを自動で生成する機能のセキュリティの脆弱性を回避するための機能。  

7.Reservationアプリケーションのroomsコントローラーのindex/new/show/editなどのアクションの中に、renderメソッドが定義されていないにも関わらずビューテンプレートが正しく呼ばれ、出力される理由を説明してください。  
  - 解答  
    何も記述がない場合、Railsでは暗黙的にアクション名に相当するビューテンプレートがHTTPレスポンスとして返されるようになっているため。

  - 正解
    正解

8.ステートレスな通信とセッション情報の役割を説明してください。  
  - 解答  
    ステートレスな通信とはwebアプリケーションのようにhttpリクエストに対して、httpレスポンスを返したら終了し、値を保持しない取引のこと。  
    そんなwebアプリケーションにおいて、ログイン情報を保持させ利便性を上げるために使用する、継続的にしよう出来る情報のことをセッション情報という。  
  - 正解  
    1回のアクション内で生成するすべての情報は、次のアクションに引き継がれない。これはステートレスな通信の特徴である。  
    しかし、そのような仕組みの中でも、情報を継続して利用できる仕組みがセッションで、その情報がセッション情報という。  

9.セッション情報はどのように使用するものなのかを説明してください。  
  - 解答  
    セッション情報は個人情報などの保存は避け、idなどで管理し、直接的なデータや4KB以上のデータを保存しないで使用する。 
  - 正解  
    セッション情報は、ステートフルな処理を行うには欠かせない手段ですが、クライアントとサーバーとの通信を通してやり取りされることや、クライアント側のキャッシュに保存されるなどのセキュリティ上のリスクを伴います。また、サイズ制限もあり、必要以上にセッション情報を多用したりすることは避けるべきです。そのためできる限りセッションIDを使用する方式にし、機密情報に当たるようなデータは、セッション情報には保存すべきではありません。

10.セッション情報とクッキーの関係を説明してください。  
  - 解答  
    クッキーとは一時的に保管場所として保存させておくファイルであり、セッション情報を入れておくものである。  
  - 正解  
    補足。  
    セッション情報は、デフォルトではクッキー（クライアントのWebブラウザーと簡単な情報をやり取りするためのファイル）に保持される。

## 9.2 目的に合わせた出力フォーマットの制御
### 学習前 練習問題9.2
1. respond_toメソッドの役割について説明してください。
  わからない。
2. HTML形式以外のフォーマットでHTTPレスポンスを出力するにはどうすればいいか？
  `render html: @インスタンス変数`

### Ajaxを使う際のフォーマット指定
`render json: @user`

### respond_toメソッドの役割
データフォーマットを判断し、ブロック内で指定された形式に合わせて処理を実行してくれる。

- html
- xml
- json
- rss
- atom
- yaml
- js
- css
- csv
- ics
- 画像などのその他の拡張子

> これらを指定してrenderするとURIの語尾に`.json`などのようにフォーマット名が明記される。

```ruby
def show
  @user = User.find(params[:id])
  respond_to do |format|
    format.html
    format.xml { render xml: @user }
    format.json { render json: @user }
  end
end
```

> 設定されていないフォーマットのURLをrespond_toメソッドで受け取るとUnknownFormat例外が発生する

### 学習後 練習問題9.2
1. respond_toメソッドの役割について説明してください。
  - 解答
    指定されたフォーマットで処理を振り分ける。
  - 正解
    データフォーマットを判断し、ブロック内で指定された形式に合わせて処理を実行

2. HTML形式以外のフォーマットでHTTPレスポンスを出力するにはどうすればいいか？
  - 解答
    ```ruby
    respond_to do |format|
      format.json { render json: @インスタンス名 }
    end
    ```
  - 正解
    正解

## 9.3 フィルター

### 主なフィルターメソッド
- before_action
- after_action
- around_action

```ruby
around_action :ard_search, only: [:search]

def search
  # searchアクションの処理
end

private

def ard_search
  # searchアクション実行前の処理
  yield
  # searchアクション実行後の処理
end

```

### フィルターのスキップ機能
- skip_before_action
  - before_actionで使いしたフィルターをスキップする
- skip_after_action
  - after_actionで追加したフィルターをスキップする
- skip_around_action
  - around_actionで追加したフィルターをスキップする

### スキップの具体的な使用例
ApplicationControllerにてログイン中であるかのチェック処理であるauthentication_checkを実装。

```ruby
# ApplicationControllerにて
before_action :authentication_check

private

def authentication_check
  # ログインされているかのチェック処理
end
```

```ruby
# UsersController
.....(省略).....

# BooksController
.....(省略).....
```
それぞれのコントローラーで継承されるauthentication_check

Loginコントローラーのみこれらをスキップしたいとき

```ruby
# LoginController
skip_before_action :authentication_check

```

### 練習問題 9.3
1. フィルターの役割を説明してください。また、モデルのコールバック処理との違いを説明してください。
  - 解答  
    フィルターはアクションにおいて実行前後にあらかじめ設定した処理を実行できる機能。  
    モデルのコールバックは、リソースの操作の前後だが、フィルターはアクションの前後であるため、リソースの操作にいとわない。

  - 正解  
    正解。
    フィルターとは、すべてのアクションに対して、前処理・後処理を設定する役割を提供するもの。  
    コールバックは、モデルを通してデータベースへ登録するデータの処理の前後に実行するものだが、フィルターは、そのモデルの処理を含むアクションの前後に呼び出す処理。  
  
2. ReservationアプリケーションのRoomsコントローラーのshow/editアクションが、何も記述されていないのに正しく処理される仕組みについて説明してください。
  - 解答  
    before_actionメソッドによってshowおよびeditアクションの実行前にidを取得するfindメソッドをprivateメソッド内で定義しているため。

  - 正解  
    正解。
  
3. Basic認証とダイジェスト認証の違いおよび実装方法について説明してください。
  - 解答  
    Basicは暗号化されず、ダイジェスト認証は暗号化される。

  - 正解  
    違いについては正解。  
    実装方法についての説明がない。  
    両方ともApplicationControllerに記述する。  

    BASIC認証は、http_basic_authenticate_withメソッドを使用し、下記のように記述する。  

    ```ruby
    # ApplicationController
    http_basic_authenticate_with name:"guest",password: "password"
    ```

    ダイジェスト認証は、ユーザー名とパスワードをMD5方式のハッシュ形式で暗号化して送信する方式  
    authenticate_or_request_with_http_digestメソッドを利用する。  

    ```ruby
    # ApplicationController
    USERS = {"guest" => "password"}
    before_action :authenticate


    private
      def authenticate
        authenticate_or_request_with_http_digest do |username|
          USERS[username]
        end
      end
    ```
