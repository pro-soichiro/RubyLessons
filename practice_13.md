# Active SupportとRailsのテスト
## Active Supportの拡張メソッド

### Q.拡張メソッドのうち、present?とpresenceの使い方の違いについて説明してください。
- **解答** present?は値の有無を真偽値で返すのに対して、presenceは値がある場合、値を返し、ない場合はnilを返す。
- **正解** 正解。

### Q.拡張メソッドを組み合わせて、次に示す原文の文字列を、結果として示される20文字の文字列に切り詰めるよう、メソッドチェーンを利用したコードを作成してください。
**原文:** 「" 私は、山田 太郎です。 ##よろしくお願いします。  ##      "」
**結果:** 「"私は、山田 太郎です。よろしくお..."」
- **解答** `原文.squish.remove(/#/).truncate(20)`
- **正解** 正解だが、/##/でもOK

### Q.tryメソッドはどのような場面で使用するのに便利か、その特徴も含めて説明してください。
- **解答** 
- **正解** レシーバーのオブジェクトが存在する(nilでない)場合のみ。引数に指定される特定のメソッドを実行する。
`@user.try(:name)`
活用タイミングとしては、レシーバーの値が空の場合に無視しても良い処理などに使用。

### Q.delegateやwith_optionsは、表現を簡潔にするのに役立ちます。どのような場合に、どのように使用するかを説明してください。
- **解答** with_optionsは共通のオプションを付与させたい複数のメソッドがある場合においてブロックで囲み定義することで、一つの記述で完結のオプションをつけることができる。
- **正解** with_optionsについては正解。  
delegateメソッドは、オブジェクトの特定のメソッドを委譲することで、自分のメソッドのように簡潔に使用できる。  
例として、UserモデルとProfileモデルが1対1の親子関係にある場合を想定。  
Profileモデルに設定しているnameを通して、Userの名前を取得する時、通常`user.profile.name`のように使用する。この場合、下記のように記述することで、`user.name`だけで使用できるようになる。

```ruby
class User < ActiveRecord::Base
  has_one :profile
  delegate :name, to: :profile
end
```

## テスト
### Q.テストの目的は？
- **A.** 提供するサービスの品質を継続的に一定のレベルで維持し、スピードを保って機能を改善・拡張していくための重要な役割がある。

### Q.具体的な確認内容を3つ挙げなさい。
- **A.** 宛先URIが予期した動作をしているか、アプリケーションおよびデータベースの状態が適切に更新されるか、正しくない処理をしたときにエラーになり、データベースが適切な状態で維持されるか

### Q.TDDとは何か？
- **A.** テスト駆動開発の略称で、テストの仕組みを作りながら開発を進めていく手法のこと。

### Q.テストの目的は何か、説明してください。
- **解答** 要件通りに機能しているか確認できる。
- **正解** テストは、作成中のアプリケーションが正しく動作することを保証するための検証であると同時に、作成済みのアプリケーションを改善・改造していく場合の作成済みの機能の品質を保証し、正当性・妥当性を確認するために必要なもの。

### Q.テストディレクトリの構成とそれぞれの役割、およびフィクスチャファイルの役割について説明してください。
- **解答** テストディレクトリには、コントローラーやメーラー、モデルなどで各それぞれの機能別に、テストが行えるようになっている。フィクスチャファイルにはテストで使用するデーもデータの情報をyml形式で記述し、使用することができる。
- **正解** テストようのディレクトリは、testディレクトリの中にある主に**目的別のテストコードを保存するディレクトリ**と、テストデータを保存するディレクトリで構成されている。フィクスチャファイルは、テストのためのデータを事前に登録するためのファイル。通常、モデルごとにYAML形式のファイルとしてフィクスチャズディレクトリ内に作成する。

### Q.フィクスチャファイルとseedsデータとの違いを説明してください。
- **解答** フィクスチャファイルはテストようデータであり、データベースを使用しないが、seedsデータはデータベースを使用した初期データとして管理することができる。
- **正解** fixturesディレクトリに保存するフィクスチャファイルは、テストデータが記述されたファイル。フィクスチャファイルのテストデータは、初期データを登録するためのseedsデータと異なり、バリデーションなどの影響を受けない。

### Q.テストの種類と役割について説明してください。
- **解答** 
- **正解** テストは、大きくモデル詳細テスト・機能テスト・システムテストに分けられる。  
モデル詳細テストは、ここのモデルのバリデーションやCRUD動作などの実装内容を確認する。  
機能テストは、HTTPリクエストを通して、HTTPレスポンスを返す一連の機能の流れに基づく操作と結果に基づくデータの整合性を確認する。システムテストは、ユーザーの画面操作を踏まえた一連の機能の整合性を確認する。

### Q.テストコードの記述方法、およびテストコードの実行ルールについて説明してください。
- **解答**
- **正解** 
  - テストコードは、テストの目的別のファイルに一つ一つのテストをtestメソッドのブロック処理として記述する。  
  - 一つ一つのテストにはわかりやすい名前を記述し、テストの目的をわかりやすくする。   
  - テストブロックの中は、テストの手順に従ったコードを記述し、テスト評価メソッド（assert）を使用して、結果の妥当性を評価する。
  - テストファイルはランダムに実行される。

### Q.setup/teardownメソッドの役割について説明してください。
- **解答** テストにおけるコールバックのような役割で、setupはテストの前、teardownはテストの後に実行する処理を記述するメソッドである。
- **正解** 正解。


