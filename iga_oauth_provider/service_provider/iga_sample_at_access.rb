require 'rubygems'
require 'oauth'
require 'oauth/consumer'

CONSUMER_KEY        = 'd1QoG7kftoxprzFgoLZz'
CONSUMER_SECRET     = 'WB30de6Pg4yQq5qeyHrwS1J2gaLtJrgssXu7BG0B'
ACCESS_TOKEN        = 'fFH5yu5YMl0jqQrpPzFW'
ACCESS_TOKEN_SECRET = '7Neup3OU4f2wm5HWqTo2IIxsrZgMdAPFJw9IhuUh'

consumer = OAuth::Consumer.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  :site => "http://localhost:3001",
  :authorize_url => "http://localhost:3001/oauth/authorize"
)

access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
response = access_token.get(
  '/oauth/at_access',
  {})

puts response.inspect, response.body
