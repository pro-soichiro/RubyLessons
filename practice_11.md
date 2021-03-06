# ビューを支える機能
## 11.1 アセットパイプライン
### Q. RailsにおけるAssetとは何か？
- **A.** HTMLを除く、画像・CSS・JavaScriptのこと
### Q. それぞれのディレクトリがあるが、それらを一括して管理しているのはなんというファイルか？
- **A.** `assets/config/manifest.js`
### Q. Sprocketsとは何か？
- **A.** アセットを効率的に管理する仕組み
### Q. Sprocketsを使用すると何ができるか？
- **A.** 設定した複数のアセットを一つに連結して1本のパイプのように利用できる。これをアセットパイプラインという。
### Q. アセットパイプラインの利点を2つあげなさい。
- **A.** 必要なアセットを役割別に個別のアセットとして管理できる。利用するときは、1つのアセットのようにして効率的に実装できる。
### Q. Sprocketsにはどのような機能があるか、3つ挙げなさい。
- **A.** パスの管理とコンパイルとファイル間依存関係の管理
### Q. Sprocketsが処理するための基本となるファイルのことをなんというか？
- **A.** マニフェスト
### Q. Railsアプリケーション生成時のスタイルシート用のマニフェストのファイル名は？
- **A.** application.css

```css
/*
*= require_tree .
*= require_self
*/
```

### Q. Railsアプリケーション生成時のJavaScript用のマニフェストのファイル名は？
- **A.** application.js

```javascript
//= require rails-ujs
//= require turbolinks
//= require_tree .
```

### Q. Sprocketsが処理するマニフェスト内の各要素をなんというか？
- **A.** ディレクティブ
### Q. マニフェストのディレクティブにおいて`require`はどのような意味を持つか？
- **A.** 引数として指定されたファイル内容を読み込み、自身より前に挿入する。重複している場合、最初に一度しか読み込まない。
### Q. マニフェストのディレクティブにおいて`include`はどのような意味を持つか？
- **A.** `require`と同様の処理を行うが、重複していても都度読み込む
### Q. マニフェストのディレクティブにおいて`require_tree`はどのような意味を持つか？
- **A.** 引数として指定されたディレクトリ直下のファイルをアルファベット順に読み込み、自身より前に挿入する。
### Q. マニフェストのディレクティブにおいて`require_self`はどのような意味を持つか？
- **A.** 自身のファイルの読み込み順を指定し、自身の内容を挿入する。
### Q. マニフェストのディレクティブにおいて`stub`はどのような意味を持つか？
- **A.** 引数に渡したファイル名を無視するように動作する。
### Q. `require_tree`ディレクトリに指定されたパス`.`は、何を表すか？
- **A.** カレントディレクトリ
### Q. 開発環境ではconfig/environments/development.rbファイルにおいて`config.assets.debug = true`となっているため、何が行われていないか？
- **A.** 各アセットが個別に取り込まれて、アセットパイプラインの一本化が行われていない。


## 練習問題11.１
### Q. Railsアプリケーションにおいて、アセットとは何を意味しますか？その種類についても説明してください。
- **解答** HTML以外のスタイルを整えるCSS、動的なビューを作成するJavaScript、Webアプリケーションの表示に使用する画像を意味する。
- **正解** 正解。補足するならば、CSSはデザイン、JavaScriptは画面上でのマウス動作やパーツ動作に関する設定。
### Q. Railsのアセットの標準的な管理方法について説明してください。
- **解答** アセットディレクトリのconfigディレクトリの中のmanifest.isで管理されている。
- **正解** app/assetsディレクトリでアセット全体を管理し、画像はその中のimagesディレクトリ、JSはJavaScriptsディレクトリ、CSSはstylesheetsディレクトリに配置し、assetsディレクトリ内のconfigディレクトリにて、それぞれに対応するディレクトリを管理するmanifest.jsで管理している。
### Q. アセットパイプラインおよび、Sprocketsの役割について説明してください。
- **解答** アセットパイプラインとは個別の役割を持つアセットを１つのファイルにまとめて管理する仕組み。SprocketsはそのためのGemツール。
役割としては、パスやコンパイルがある。
- **正解** Sprocketsはアセットを簡単かつ効率的に扱えるようにする機能を提供するGemパッケージであり、設定した複数のアセットを一つに連結して利用することができる。これをアセットパイプラインという。
### Q. 開発モードと本番モードにおけるデフォルト状態での、アセット管理に関する環境設定の違いについて説明してください。
- **解答** 開発モードではコンパイルが自動でされ、デバック設定がfalseになっている。本番モードではしっかりと検証なされた上で、実装される必要があるため、`config.assets.debug = true`となっており、アセットパイプラインの機能が働いていない状態となる。
- **正解**  
  アセットパイプライン(一本化)の機能とコンパイル機能(coffeescript/scssを変換)がある。  
  - アセットパイプライン`config.assets.debug`(アセットデバッグ設定)  
    - 開発環境  
      デフォルトではアセットデバッグ設定が有効（`config.assets.debug = true`）になっているため、各アセットが個別に取り込まれ、アセットパイプラインの一本化機能が行われない。
    - テスト、本番環境  
      指定されていないため、デフォルト状態として`false`となっており、各アセットが一つになり取り込まれ、アセットパイプラインの一本化機能が行われる。
  - コンパイル`config.assets.compile`  
    - 開発環境  
      修正したものや追加したものがすぐに確認できる必要があるため、有効
    - 本番環境  
      十分な検証を行なって機能を組み込む必要があるため、無効  
      そのため、`$ rails assets:precompile RAILS_ENV=production`コマンドでプリコンパイルするか、`config.assets.compile = true`にすることで自動的にコンパイルされるが、本番環境では推奨されない。

## 11.2 非同期更新Ajax、キャッシング機能
### Q. Ajaxとは何か？
- **A.** Action Viewがサポートする機能の一つで、ページの変更部分のみを非同期で入れ替え、待ち時間を少なくしてビュー表示の高速化を図る技術。
### Q. JSONとは何か？
- **A.** 軽量のデータ交換フォーマット。JavaScript Object Notation
### Q. キャッシングとは何か？
- **A.** Action Viewの提供する機能の一つで、時間がかかるビューの生成・出力といった処理をメモリやファイル上にキャッシュとして保存し、再利用して高速化を図る技術。
### Q. Railsのキャッシングのタイプは単位によって3種類ある。それは何か？
- **A.** ページキャッシュ、アクションキャッシュ、フラグメントキャッシュ

## 練習問題 11.2
### Q. Ajaxとは何かを説明してください。
- **解答** 変更箇所のみを差し替えることで、ページ表示の高速化を図る仕組み
- **正解** ページ単位で同期を取るやりとりによりページ全体を送り返すのではなく、ページの一部である「変更部分のみ」を非同期で入れ替え、待ち時間を少なくしてビュー表示の高速化を図るための技術。
### Q. Ajaxを実装する場合の最低限必要な環境設定について説明してください。
- **解答** gemパッケージjquery-railsを導入し、bundle installする。assets/javascritpts/application.jsファイルにおいて、最上段に`//= require jquery`を追記する。
- **正解** rails-ujsの設定とjQueryの設定（gemの追加）とAjaxをリクエストするビューテンプレートの設定。

### Q. キャッシングの目的について説明してください。
- **解答** ページ表示の高速化
- **正解** 時間がかかるビューの生成・出力といった処理をメモリやファイル上にキャッシュとして保存し、再利用して高速化を図る。

### Q. キャッシングの種類とキャッシュの保存場所について説明してください。
- **解答** キャッシングにはページキャッシング、フラグメントキャッシングとも一つの3種類がある。デフォルトでのキャッシュの保存場所はキャッシュメモリー。
- **正解** キャッシュする単位によってページキャッシュ、アクションキャッシュ、フラグメントキャッシュの3種類がある。本番環境ではキャッシュストア、開発環境では、メモリーストアに保存される。


## 11.3 i18n国際化対応機能
### Q. i18nとは何か？
- **A.** 多言語管理をするためのGemパッケージ
### Q. 多言語対応を行うために必要な2つの準備とは何か？
- **A.** 多言語環境を使用する設定とロケール辞書の作成
### Q. 多言語環境を使用する設定は具体的に何をするか？
- **A.** config/initializersディレクトリにlocale.rbというファイルを作成し、下記のコードを記述する。
  
```ruby
# アプリケーションで有効とする言語を指定（英語と日本語のみ）
I18n.available_locales = [:en,:ja]

# デフォルトの言語を指定する。
I18n.default_locale = :ja
```

### Q. ロケール辞書の作成は具体的に何を行うか？
- **A.** config/localesディレクトリに、ロケール辞書ファイルの拡張子として使用されている.yml(ヤムル)を使用して、言語ごとに作成する。日本語の場合`ja.yml`とする。ファイル内の記述方法は下記のように行う。

```ruby
ja:
  hello: "こんにちは、ようこそ世界へ"
  everybody:
    e1: "みなさん"
    e2: "諸君"
    e3: "皆様"
    e4: "各々方"
```

> 原則として文字列形式だが、文字の切れ目がなければ`"`および`'`は不要。
> 呼び出し方は`I18n.t :hello`や`t :hello`、階層化されたキーに対しては`t 'everybody.e1'`のように指定する。

## 練習問題 11.3
### Q. I18nの国際化対応の仕組みについて簡単に説明してください。
- **解答** 多言語環境を使用する設定と対応するための辞書を作成し、読み込ませることで、複数言語に対応できる。
- **正解** i18nは、config/localsディレクトリ内に国言語ごとの辞書をymlファイルで作成することにより、ビュー表示に伴うタイトルやメッセージに対して、国言語変換を行う仕組みのこと。デフォルトでは、英語になっているため、日本語をデフォルトにするためには環境設定を変更する。


a.ユーザーモデル（User）に管理者権限admin属性（ブーリアン形式）を追加するマイグレーションファイルを作成し、usersテーブルに実装します。また、admin属性のデフォルト値はfalseにしておきます。
`$ rails g migration add_admin_to_users admin:boolean`

```ruby
class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
```

b.管理者登録機能は作成せず、管理者権限ユーザー（admin属性：true）を、事前にシード機能（seeds）でテーブルに追加します。パスワードには暗号化処理が必要です。

c.ログインユーザーの管理者権限（admin属性）がtrueの場合のみ、Room機能のnew/create/edit/update/destroyを有効にし、falseの場合、ルートへリダイレクトします。その際、ボタンやメニューも非表示にします。

d.ユーザー情報登録機能は現行のままで変更しません。

5.重複している部分やゴミの部分について整理してください。
●自動生成されて使われていない不要なビューやヘルパーファイル、アセットファイルを削除してください。
●entriesコントローラーのアクションの共通部分をbefore_actionでまとめてください。

6.予約エントリのuser_idだけでユーザーの情報とひも付けて、予約エントリのユーザー名やメールアドレスを持たなくても良いよう変更しましょう。なおこの課題は、本書を最後まで読み終えてからでもかまいません。
