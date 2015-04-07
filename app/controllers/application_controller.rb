class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    msg = 'You are not authorized to perform this action.'
    flash[:alert] = I18n.t "pundit.#{policy_name}.#{exception.query}",
                           default: msg
    redirect_to request.referrer || root_url
  end
end
