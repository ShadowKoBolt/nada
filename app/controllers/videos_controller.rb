class VideosController < BaseController
  before_action :authenticate_user!

  def show
    @video = Video.friendly.find(params[:id])
  end

  def index
    @tags = ActsAsTaggableOn::Tag.most_used
    @videos = Video.all
  end
end
