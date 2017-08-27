module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!

    layout 'application_admin'

    rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

    private

    def authorize_user!
      authorize :admin, :show?
    end

    def handle_not_authorized
      redirect_to(root_path, notice: "You are not authorized to view this area")
    end
  end
end
