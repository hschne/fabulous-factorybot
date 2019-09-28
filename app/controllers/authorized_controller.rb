class AuthorizedController < ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :verify_logged_in
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def verify_logged_in
    redirect_to(root_path, flash: { error: 'You must be logged'}) unless current_user
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t("#{policy_name}.#{exception.query}",
                      scope: 'pundit',
                      default: :default)
    redirect_to(request.referrer || root_path)
  end
end
