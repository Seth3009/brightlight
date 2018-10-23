module Concerns
  module ControllerWithImpersonation
    extend ActiveSupport::Concern

    included do
      helper_method :devise_current_user
    end

    def current_user
      if session[:impersonated_user_id].blank?
        devise_current_user
      else
        User.find(session[:impersonated_user_id])
      end
    end

    def devise_current_user
      @devise_current_user ||= warden.authenticate(:scope => :user)
    end

  end
end