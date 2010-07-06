
consumer: script/server -p 3000
privider: script/server -p 3001

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
oauth_client_controller の current_userメソッドを変更
  def current_user
    #    User:new
    User.authenticate('igaiga', 'hoge')
  end

Service Provider input
  Application URL : http://localhost:3000
  Callback URL : http://localhost:3000/my_sample/callback

→成功すればaccess_token がもらえる


■AccessTokenをつかったアクセス
制御したいメソッドの前にbefore_filterを指定する
before_filter :oauth_required, :only => [:at_access]

#http://localhost:3001/oauth/at_access?access_token=fFH5yu5YMl0jqQrpPzFW&access_secret=7Neup3OU4f2wm5HWqTo2IIxsrZgMdAPFJw9IhuUh
