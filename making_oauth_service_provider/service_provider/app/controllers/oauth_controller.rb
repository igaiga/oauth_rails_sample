require 'oauth/controllers/provider_controller'
class OauthController < AccountController
#class OauthController < ApplicationController
  include OAuth::Controllers::ProviderController
#  before_filter :oauth_required, :only => [:at_access]

  def login_required
    true
  end

#   def at_access
#   end

  
  # Override this to match your authorization page form
  # It currently expects a checkbox called authorize
  # def user_authorizes_token?
  #   params[:authorize] == '1'
  # end
  
end
