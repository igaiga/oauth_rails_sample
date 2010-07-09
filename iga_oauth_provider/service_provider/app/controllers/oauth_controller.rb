# -*- coding: undecided -*-
require 'oauth/controllers/provider_controller'
class OauthController < AccountController
#class OauthController < ApplicationController
  include OAuth::Controllers::ProviderController
  # p 'OauthController igaiga'
  #  p self.filter_chain
  # よくわからないのだが、ここで before_filter を定義すると二重定義になってしまう
  #  before_filter :oauth_required, :only => [:at_access]
  #  p self.filter_chain
  #  before_filter :login_or_oauth_required, :only => [:at_access]

  # Override this to match your authorization page form
  # It currently expects a checkbox called authorize
  # def user_authorizes_token?
  #   params[:authorize] == '1'
  # end
  def login_required
    false
  end

   def at_access
     p 'at_access success!'
   end

end
