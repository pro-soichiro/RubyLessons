B# 4-1  RailsコンポーネントとMVCの基礎知識
## 1 MVCの役割を構成する、Railsの各コンポーネントの名前を列挙し、それぞれの役割を説明したください。

- Active Record  
モデルの機能の補助
- Action Controller  
コントローラーの補助
- Action view  
ビューに関する機能の補助
- Action dispauch  
ルーティングに関する機能の補助

### 正解

- Active Record  
役割：リソース管理
- Action View  
役割：ユーザーインターフェース
- Action Controller  
役割：リソース制御
- Action Dispatch(ルーター)  
役割：Webリクエストの解析とルーティング

## 2 ルーターの役割について簡単に説明し、ルーターとコントローターのコンポーネントの関係について、説明してください、

### 解答
ルーターはHTTPリクエストを受け取り、リクエストに従って、どのコントローラーを呼ぶのかを決める場所です。  
コントローラーはルーターの命令に従い、必要なリソースをモデル経由でデータベースより抽出する命令を出したり、ユーザーインターフェースに表示するHTMLを作るようビューに指令を出す役割をします。

### 正解
ルーターの役割はWebリクエストの解析とルーティングを担っています。  
ルーターはアクションの振り分けを、コントローラーはアクションの制御を行うという関係になっています。

## 3 メール制御のコンポーネントについて、その名前を挙げ、役割を簡単に説明してください。

### 解答
Action Mailer メールを送る機能を持つ。

### 正解
Action Mailer メールの送受信において、クライアント制御機能やメールテンプレートの生成機能を提供します。

#### 具体的にできること
- 新規登録された時に、ユーザーに対して確認メール
- エラー発生時に、管理者にメール

## 4 Rubyの拡張メソッドを提供するコンポーネントについて説明してください。

### 解答
わかりません。

### 正解
Active Support  
Rubyの拡張メソッドなどを提供します。起動時に標準で組み込まれます。

## 5 Rails 5以降で新しく実装された2つのコンポーネントについて説明してください。

### 解答
わかりません。

### 正解
Action Cable(アクションケーブル)  
クライアントとサーバー間で行うチャットのようなリアルタイム通信機能を提供します。
#### 何ができるのか
- チャットアプリが作れる

Active Storage  
Active Recordと連携した画像・動画などのファイルアップロード、参照機能を提供します。  
Amazon S3などのような、クラウド上のデータ地区正規サービスとスマートに連携します。  
#### 何ができるのか
- これまでRefileを使っていたのが、標準で画像アップロードが可能になった

## 6 Railsフレームワークの起動プロセスなどを提供するコンポーネントについて説明してください。

### 解答
わかりません。

### 正解
Railties  
Railsフレームワークの書くとなるコンポーネント。  
アプリケーションの起動プロセスや、Railsコマンド実行のインターフェース、およびRailsジェネレーターを提供します。

## 7 ERBの役割について、簡単に説明してください。

### 解答
HTMLの中にRubyを埋め込んだ時に表示のサポートをするパッケージ。

### 正解
ビューテンプレートなどに埋め込める文章埋め込み用のRubyスクリプト。  
拡張子が.erbのファイルとして記述することで、埋め込まれているRubyコードを実行し、値の埋め込みを行う。
#### スクリプトとは？
機械語への変換を省略して、解釈実行できるようにしたプログラミング言語のこと。

## 8 Rails 5のデフォルトのWebサーバー機能について簡単に説明してください。

### 解答
Puma。

### 正解
Puma  
効率的なスレッドを使用した並列処理を実現できる。  
Pumaのおかげで、開発時に即座にWebアプリケーションの確認を行うことができる。

## 9 Rakeの役割について説明してください。

### 解答
わかりません。

### 正解
Rubyで作られた構築確認用のツール。
Rails環境においては、データベースのマイグレーションなどで使用する。


# 4-2 Railsのディレクトリ構成

Rails開発を進めていく上で、生成されたフレームワークの各ディレクトリやファイルが

- どのような場合にそれらを使用するのか
- どのような役割を果たすのか

を知っておくことが重要

### ディレクトリ

- .git
gitが利用するディレクトリ。gitとはバージョン管理ツールのこと。

- app
アプリケーションに関する情報が入っている。モデル、コントローラー、ビューはこの中にある。

- bin
アプリケーションの起動に使用するプログラム（スクリプトファイル）を管理するディレクトリ。

- config
実行環境に関する設定情報

- db
データベース関連の設定情報  
スキーマファイルやマイグレーションファイルが入ったマイグレートディレクトリが存在する。

- lib
複数のアプリケーション間で共有するライブラリを管理するためのディレクトリ。

- log
アプリケーションの実行時のログファイルを保持するディレクトリ。

- public
アップロード画像といった静的ファイル、静的トップページなど、静的な公開リソースをおくためのディレクトリ。

- storage
Active storageのデフォルトローカルストレージ

- test
Rails標準の各種テスト用のコードファイルやテストデータ（フィクスチャ）などを管理するためのディレクトリ。

- tmp
Rails稼働中の一時的な情報（キャッシュ、プロセスID(pid)、セッション）などを管理するディレクトリ。

- vendor
サードパーティ製のコードや素材をおいておくディレクトリ。

### ファイル

- .gitignore
gitのバージョン管理対象から外すべきファイルなどを記述するファイル

- .ruby-version
Rubyのバージョンを管理。

- config.ru
RackがRailsサーバーの起動のために使用する設定ファイル

- Gemfile
Gemパッケージの設定ファイル

- Gemfile.lock
bundle installされたGemパッケージの依存関係を管理するためのファイル。  
このファイルに基づいてパッケージ管理されている。
  - 補足
    bundle installを実行すると、Gemfile.lockというファイルが生成される。  
    組み込まれたGemパッケージのバージョンは、Gemfile.lockを削除して、再度bundle installを実行するかbundle updateを行わない限り、バージョンの依存関係を維持してくれる。  

- package.json
nodeのパッケージ管理ツールnpmを使用する場合に必要なファイル。

- Rakefile
Rakeタスクコマンドの実行を管理するためのファイル。

- README.md
起動実行の手順に関して記述する、説明用のファイル


## appディレクトリ内のファイルやディレクトリについて

- controllers > concerns
コントローラー共通のコードを管理するためのディレクトリ

- helper
ヘルパーモジュールを管理するためのディレクトリ。  
共通のヘルパーメソッドを提供するためのApplicationHelperが生成される。

- jobs
ジョブクラスを管理するディレクトリ

- mailers
メーラークラスを管理するディレクトリ

- models
モデルクラスを管理するディレクトリ

## configディレクトリ内のファイルやディレクトリについて

- environments
実行環境（開発、テスト、運用）ごとの設定情報を管理するディレクトリ
デフォルトはdevelopmentモード

- initializers
初期化情報の設定ファイルを管理するディレクトリ

- locales
各国言語別の表示文を管理する国際化対応辞書の役割のロケーションファイル（.yml）を管理するディレクト

- application.rb
各実行環境に共通する設定を行うファイル。
ただし、environmentsディレクトリが優先。

- boot.rb
Gemfileの場所を管理し、起動時にGemfileの一覧からgemのセットアップを行うファイル

- cable.yml
Action Cable用の、環境別のデフォルトキューアダプターを管理するためのファイル

- credentials.yml.enc
暗号化キーなどを管理するためのファイル

- database.yml
データベースの環境設定を行うためのファイル

- environment.rb
Rails sで、application.rbの初期化を行うファイル

- master.key
credentials.yml.encの情報を復元するためのキーが保存されているファイル

- puma.rb
Pumaの実行環境を設定するためのファイル

- routes.rb
ルーターの定義ファイル

- spring.rb
Springの制御の設定を行うファイル
  - Springとは、 Railsアプリケーション初回起動時に必要なライブラリをロードする役割を担い、効率的な開発を行えるようにするためのプログラム。

- storage.yml
Active Storageの環境設定を行うためのファイル

## 練習問題 4.2

### 1 次にあげる、Railsのそれぞれのディレクトリ（フォルダー）の役割を簡単に説明してください。
- app  
  - 解答  
  アプリケーションに関する情報が入ったディレクトリ。モデル、コントローラー、ビューファイルは全てこの中にある。

  - 正解  
  アプリケーションに関する情報を管理するディレクトリ。

- assets  
  - 解答  
  ビューに関するリソースがまとまっているディレクトリ

  - 正解  
  Railsアセットファイルを管理するディレクトリ。これが示す、アセットとはビューに組み込むHTML以外のCSSやJavaScript、画像などの要素のこと。

- controllers  
  - 解答  
  モデルとビューに命令を送る、アクションを制御する場所

  - 正解  
  コントローラークラスを管理するディレクトリ。

- models  
  - 解答  
  データベース（リソース）とのやり取りをするファイルがまとまっているディレクト。

  - 正解  
  モデルクラスを管理するディレクトリ。

- views  
  - 解答  
  リクエストに対し、htmlを生成するビューファイルが配置されているディレクトリ。

  - 正解  
  ビューテンプレートを管理するディレクトリ。

- config  
  - 解答  
  アプリケーションの設定情報について様々なディレクトリやファイルが格納されているディレクトリ。

  - 正解  
  実行環境に関する設定情報が入ったディレクトリ。

- db  
  - 解答  
  データベースに関する情報が格納されているディレクトリ。スキーマやマイグレーションファイルが配置されている。

  - 正解  
  正解

- environments  
  - 解答  
  わかりません。

  - 正解  
  実行環境ごとの設定情報を管理するディレクトリ。  
  実行環境とは、開発＝development：テスト＝test：運用＝productionの3つ  
  デフォルトは開発

### 2 controllers,models配下のconcernsの役割について説明してください。
- 解答  
それぞれ（controllersとmodels）において共通する処理を記述する。

- 正解  
共通のコードを管理するためのディレクトリ。

### 3 ルートを設定するファイルとその管理場所について説明してください。

- 解答  
ルートを設定するファイルは「routes.rb」というファイルで、configディレクトリの直下に生成されています。

- 正解  
正解

### 4 環境設定の3つのモードとはなにか説明してください。

- 解答  
開発 = development
テスト = test
運用 = production

- 正解  
正解

### 5 config/application.rbとenvironmentsディレクトリとの関係について説明してください。

- 解答  
config/application.rbはアプリケーションにおける共通の設定情報を管理するファイルであるのに対し、environmentsディレクトリは実行環境ごとに設定情報を管理するディレクトリ。

- 正解  
config/application.rbは核実行環境に共通の設定を行うファイル。environmentsディレクトリ内の個別設定が優先される。
environmentsディレクトリは実行環境ごとの設定情報を管理するディレクトリ。
ちなみに名前がほぼ同じのconfig/environment.rbファイルはRailsサーバーの起動時に、application.rbの初期化を行うファイル。


### 6 credentials.yml.encの役割とmaster.keyの関係を説明してください。

- 解答  
credentials.yml.encは
master.keyはcredentials.yml.encファイルの暗号を復元するためのキーを保管しているファイル。

- 正解  
credentials.yml.encは暗号化キー（secret_key_baseなど）を管理するためのファイル。
master.keyはcredentials.yml.encの情報を復元するためのキーが保存されているファイル。

### 7 GemfileとGemfile.lockの関係を説明してください。

- 解答  
Gemfileは、gemを管理するファイルで、Gemfile.lockは実際にインストールされているファイルが記述されているファイルです。  
gemを追加する場合は、gemfileに記述し、gemfile.lockを削除した上で、bundle installするか、bundle updateしないと設定が反映されない。  
アプリケーションはgemfile.lockと整合性を維持した設定を行う。  

- 解答  
GemfileはRailsで使用するGemパッケージの設定ファイル。
Gemfile.lockはbundle installされたGemパッケージの依存関係を管理するためのファイル。
ほぼほぼ正解。

### 8 次のファイルの生成場所について、簡単に説明してください。
- schema.rb  
- database.yml

- 解答  
アプリケーションディレクトリ直下のdbディレクトリ

- 正解  
schema.rbに関しては解答で正解。  
database.ymlはconfigディレクトの直下に配置される各実行環境について、データベースの環境設定を行うためのファイル。  

### 9 レイアウトと他のビューの関係を説明してください。

- 解答  
よくわからない。

- 正解  
layoutsは共通のレイアウトを管理するディレクトリ。  
ビューテンプレート用のapplication.html.erbがそれに値する。  
他のビューは各コントローラー名のディレクトリで対応するビューテンプレートが管理されている。  


### 10 HTML以外の画面構成要素と、その管理方法を説明してください。

- 解答  
app/assetsディレクトリ内にcss,javascript,画像ファイルなどが管理されている。

- 正解  
正解

# 4.3 railsコマンド

### Rails new
Rails アプリケーションの生成
```bash
$ rails new アプリケーション名[オプション]
```

Active Recordの生成をスキップ
```bash
$ rails new application -O
# もしくは
$ rails new application --skip-active-record
```

使用データベースを指定する時
```bash
$ rails new application -database=mysql
```
デフォルトではSQLite3が使用される。  
  
dオプションで使用できるデータベースの種類を確認したい時
```
$ rails new -h
```
実行結果
```bash
-d, [--database=DATABASE]  
# Preconfigure for selected database (options: mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc)
```

テスト関連ツールのフレームセットを生成したくない時
```bash
$ rails new application -T
# もしくは
$ rails new application --skip-test-uni
```

bundle installをさせたくない時
```bash
$ rails new application -B
# もしくは
$ rails new application --skip-bundle
```

concernsやimagesなどの空ディレクトリを生成したくないとき
```bash
$ rails new application --skip-keeps
```

APIを作るためのオプション  
ビューに関連した機能の生成を行わなず、軽量なフレームワークを作成する。
```bash
$ rails new application --api
```

### rails g(Railsアプリケーション要素の生成)

基本
```bash
$ rails g ジェネレーター種類 引数 [オプション]
```

コントローラーを生成する  
コントローラー名は小文字複数形(例：books)がルール
```bash
$ rails g controller コントローラー名
```

アクション名を指定し、対応するルートをルーターに追加し、viewのスケルトンを生成して欲しいとき
```bash
$ rails g controller コントローラー名 アクション名
```

モデルの生成とマイグレーションファイルをdb/migrateディレクトリに生成する時に使用  
モデル名は大文字から始まる単数形がルール
```bash
$ rails g models モデル名 属性名:タイプ
# Bookモデルにstringタイプでタイトル(title)とtextタイプで感想(thoughts)を保存させたい場合
$ rails g models Book title:string thoughts:text
```

メーラーを生成したい時に使用
```bash
$ rails g mailer メーラー名 メソッド名
```

単独でマイグレーションファイルを生成したいときに使用
モデルの属性や、データベース、テーブルの変更時に使用
生成日時に基づくバージョンIDがつくため、過去のものに戻すことが可能
```bash
$ rails g migration マイグレーション名 カラム属性:タイプ
```

scaffoldにより、モデル

