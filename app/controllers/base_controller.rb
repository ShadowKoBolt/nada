class BaseController < ApplicationController
  layout 'application_base'

  before_action :authenticate_user!
end
