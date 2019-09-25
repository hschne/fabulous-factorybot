class AuthorizedController < ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t("#{policy_name}.#{exception.query}",
                      scope: 'pundit',
                      default: :default)
    redirect_to(request.referrer || root_path)
  end
end
