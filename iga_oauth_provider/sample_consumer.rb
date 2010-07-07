require 'rubygems'
require 'oauth'
require 'oauth/consumer'

CONSUMER_KEY        = 'znTAGqe0IED9P1NRdMeu'
CONSUMER_SECRET     = 'J8L8QxmHXltKtDwcP0Y7kevuorj2RG0ua0d5kKbt'
ACCESS_TOKEN        = '5g8ldDMT2XU9a5j5tuNZ'
ACCESS_TOKEN_SECRET = 'mQMr5HHN1QEK4cAjxBrySXkfF34oUdm0ldB0M0Xt'
#ACCESS_TOKEN        = ''
#ACCESS_TOKEN_SECRET = ''

consumer = OAuth::Consumer.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  :site => "http://localhost:3001",
  :authorize_url => "http://localhost:3001/oauth/authorize"
)
access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
response = access_token.get('/oauth/at_access')
puts response.inspect, response.body
