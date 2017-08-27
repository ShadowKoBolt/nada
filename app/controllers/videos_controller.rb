class VideosController < BaseController
  before_action :authenticate_user!

  def show
    @video = Video.find(params[:id])
  end

  def index
    @videos = Video.all
  end
end
