class VideosController < BaseController
  before_action :authenticate_user!

  def show
    @video = Video.friendly.find(params[:id])
    authorize @video
  end

  def index
    authorize :video
    @videos = Video.all
    @tags = ActsAsTaggableOn::Tag.most_used.reorder(:name)
  end
end
