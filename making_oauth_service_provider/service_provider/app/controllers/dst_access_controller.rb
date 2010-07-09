require 'oauth/controllers/provider_controller'
class DstAccessController < OauthController
#  include OAuth::Controllers::ProviderController
  before_filter :oauth_required, :only => [:at_access]
p self.filter_chain
  def at_access
    p 'igaiga'
  end
  
end
