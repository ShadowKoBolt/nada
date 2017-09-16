class MagazinesController < BaseController
  before_action :authenticate_user!

  def index
    authorize :magazine
    @magazines = Magazine.all
  end
end
