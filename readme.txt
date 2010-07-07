
consumer: script/server -p 3000
provider: script/server -p 3001

Service Provider input
  Application URL : http://localhost:3000
  Callback URL : http://localhost:3000/my_sample/callback
→provider の client_applications テーブルにconsumer key/secret が登録される



■OAuth Service Provider の作り方

sudo gem install oauth
rails service_provider
cd service_provider
script/plugin install git://github.com/pelle/oauth-plugin.git
script/generate oauth_provider
# acts_as_privider
script/plugin install git://github.com/gundestrup/acts_as_authenticated.git
script/generate authenticated user account
user.rb を修正
 has_many :client_applications
 has_many :tokens, :class_name=>"OauthToken",:order=>"authorized_at desc",:include=>[:client_application]

→http://localhost:3000/oauth_clients
undefined method `login_required' for #<OauthClientsController:0x1032070e8>

oauth_clients_controller.rb
追加
  def login_required
    true
  end

undefined local variable or method `current_user' for #<OauthClientsController:0x1035373a8>
→acts_as_auththenticated の user が必要になるっぽい。事前にログインさせてユーザーつくらせる(/account)
→/oauth/authoized

/oauth_client でコンシューマを登録
oauth_client_controller の current_userメソッドを変更(accountで作成したユーザー名とパスワードを入力(手抜き))
  def current_user
    #    User:new
    @current_user ||= User.authenticate('foo', 'bar')
　 end

Service Provider input
  Application URL : http://localhost:3000
  Callback URL : http://localhost:3000/my_sample/callback

→成功すればaccess_token がもらえる


■AccessTokenをつかったアクセス
制御したいメソッドの前にbefore_filterを指定する
before_filter :oauth_required, :only => [:at_access]

■Consumer と Provider でお話する方法
Provider を -p 3001, Consumer を -p 3000 で起動した場合

* consumer: script/server -p 3000
* provider: script/server -p 3001

!! Provider で consumer key/secret を発行する
* http://localhost:3001/account/ でてきとうにサインアップする
* /oauth_clients でクライアントを登録する
**  Application URL : http://localhost:3000
**  Callback URL : http://localhost:3000/my_sample/callback
*** →provider の client_applications テーブルにconsumer key/secret が登録される
*** consumer key/secret をコピーしておく

!! Consumer で access token を得る
* http://localhost:3000/ でてきとうにサインアップする
* new_consumer を作成する
** service provider : my_sample
** consumer key/secret 上記でコピーしたもの
** scope は空でOK
* access token を得る
** my sample - establish
** authorize access にチェックを入れ save changes
* access token/secret が表示されるのでコピーしておく

!! Consumer で access token を使ってアクセスする
sample_consumer.rb に consumer key/secret, access token/token secret を設定
実行
 #<Net::HTTPOK 200 OK readbody=true>
 <h1>You have successed to accesss with access token!</h1>
と出ればOK


■Rails3で使う方法
Gemfile に
gem 'oauth'
gem 'oauth-plugin', :git => 'git://github.com/pelle/oauth-plugin.git', :branch => 'rails3'
