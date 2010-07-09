*構成*
*iga_oauth_provider 下記の手順で作成した OAuth service provider
*oauth_consumer 参考サイトからDLしてきた OAuth consumer
*oauth_service_provider 参考サイトからDLしてきた OAuth Service Provider

*参考サイト*
* ゼロから学ぶOAuth
** http://gihyo.jp/dev/feature/01/oauth/0001

*手軽に試してみたい方*
既成の oauth_service_provider と oauth_consumer を使って起動してみましょう。
Rails2.3.8 で動かすようにしていますが、config/environment.rb のRAILS_GEM_VERSIONを変えれば動くんじゃないかと思います。

* $ sudo gem install oauth
* 両方で rake db:migrate しておきます。

gem oauth を入れ、以下のように起動したとします。 
* consumer: script/server -p 3000
* provider: script/server -p 3001

Service Provider で適当なユーザー名でサインインし、Register your application でコンシューマを登録します。
* Name : てきとうに
* Application URL : http://localhost:3000
* Callback URL : http://localhost:3000/my_sample/callback
* Support URL : 空白で
consumer key/secret をコピーしておきます。
provider の client_applications テーブルにconsumer key/secret が登録されているのが確認できます。
* $ sqlite3 development.sqlite3
* > select * from client_applications;
次にconsumer 側の設定をしてAccess key/secret を取得します。
new consumer から先ほど service provider で発行された key/secret を登録します。
* service provider: my_sample
* Consumer key: 上で取得した値
* Consumer secret: 上で取得した値
* Scope: 空白で
new access token から my sample establish を選択します。
authorize access にチェックを入れ、save changes で Access token/secret が取得できます。

*OAuth Service Provider の作り方*
oauth-plugin を利用してservice provider を自作してみます。
oauth-plugin のほかに、任意の認証プラグインが必要なので、ここでは acts_as_provider を使います。

* $ sudo gem install oauth
* $ rails service_provider
* $ cd service_provider
oauth-plugin をインストールして、ジェネレーターで作成します。
* $ script/plugin install git://github.com/pelle/oauth-plugin.git
* $ script/generate oauth_provider
acts_as_provider をインストールして、ジェネレータで作成します。
* $ script/plugin install git://github.com/gundestrup/acts_as_authenticated.git
* $ script/generate authenticated user account
oauth_controller.rb を AccountController を継承するように変更します。
* class OauthController < AccountController
* コメントアウト→ #class OauthController < ApplicationController
oauth_clients_controller.rb と oauth_controller.rb の両方に login_required メソッドを追加します。(追加しないと undefined method `login_required'エラー。)
  def login_required
    true
  end
application_controller.rb にcurrent_user メソッドを追加します。(追加しないと undefined local variable or method `current_user')
手抜きをして、最初にログインするユーザー名とパスワードをここに書いちゃいました。
  def current_user
    @current_user ||= User.authenticate('foo', 'hoge')
　 end
user.rb を修正します。
* has_many :client_applications
* has_many :tokens, :class_name=>"OauthToken",:order=>"authorized_at desc",:include=>[:client_application]
DB を作ります。
* rake db:migrate

動作確認してみます。
* $ script/server -p 3001
* http://localhost:3001/account へアクセスします。
* てきとうな名前とパスワードで登録します。(名前とパスワードをcurrent_userメソッドに書いてください。)
* In the Caboose. な画面が出ます。
* http://localhost:3001/oauth_clients へアクセスします。
* Register your application から以下を登録します。
** 任意
** Main Application URL : http://localhost:3000
** Callback URL : http://localhost:3000/my_sample/callback
** Support URL : 空白で
* 成功すれば Consumer Key/Secret が取得できます
上述のサンプル oauth_client を使ってAccess token が取得できれば成功です。

*AccessTokenをつかったアクセス*
(例えばAccountControllerなどで)制御したいメソッドの前にbefore_filterを指定する
(AccountControllerを継承したクラスでないと authorized? メソッドがないと言われます。
 なぜか、OauthControllerでbefore_filterを定義した場合はうまく動きませんでした。)
* before_filter :oauth_required, :only => [:at_access]
at_access アクションを実装
  def at_access
  end
at_access view を置きます
* app/views/account/at_access.html.erb
making_oauth_service_provider/sample_consumer.rb がconsumer側のコードです。
sample_consumer.rb に consumer key/secret, access token/token secret を設定します。
response = access_token.get('/account/at_access') にアクセス対象アクションを記述します。
実行します。
 $ ruby sample_consumer.rb
 #<Net::HTTPOK 200 OK readbody=true>
 <h1>You have successed to accesss with access token!</h1>
と出ればアクセス成功です。
アクセストークンなどをわざと不正にして、Invalidになることも確かめればOKです。


■Rails3で使う方法
Gemfile に
gem 'oauth'
gem 'oauth-plugin', :git => 'git://github.com/pelle/oauth-plugin.git', :branch => 'rails3'
