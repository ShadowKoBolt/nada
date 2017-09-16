class BaseController < ApplicationController
  layout 'application_base'

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

  protected

  def handle_not_authorized
    redirect_to members_area_path, notice: "You can't access this area at the moment - please upgrade your account first."
  end
end
