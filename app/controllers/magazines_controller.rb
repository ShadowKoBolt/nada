class MagazinesController < BaseController
  before_action :authenticate_user!

  def index
    @magazines = Magazine.all
  end
end
