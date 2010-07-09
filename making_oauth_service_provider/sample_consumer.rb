require 'rubygems'
require 'oauth'
require 'oauth/consumer'

CONSUMER_KEY        = 'sY9JUZRYUmfcCvD1eAWC'
CONSUMER_SECRET     = 'zbwAbJAPestjuo5lPo30OnqcrmA4r1LTWIELJtvN'
ACCESS_TOKEN        = 'Toqo2Ik62NHtXee8S871'
#ACCESS_TOKEN        = 'Toqo2Ik62NHtXee8S8aa'
ACCESS_TOKEN_SECRET = 'Pnkjf8po98XzdmHWzQhMRPbzuwuDZbgnVWtipACF'
#ACCESS_TOKEN_SECRET = 'Pnkjf8po98XzdmHWzQhMRPbzuwuDZbgnVWtipAaa'
consumer = OAuth::Consumer.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  :site => "http://localhost:3001",
  :authorize_url => "http://localhost:3001/oauth/authorize"
)
access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
response = access_token.get('/account/at_access')
puts response.inspect, response.body
