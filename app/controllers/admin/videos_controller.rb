module Admin
  class VideosController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:reorder]

    def index
      @videos = Video.all
    end

    def new
      @video = Video.new
    end

    def create
      @video = Video.new(video_params)
      if @video.save
        redirect_to admin_videos_path, notice: 'Video added'
      else
        render action: :new
      end
    end

    def edit
      @video = Video.find(params[:id])
    end

    def update
      @video = Video.find(params[:id])
      if @video.update(video_params)
        redirect_to admin_videos_path, notice: 'Video updated'
      else
        render action: :edit
      end
    end

    def destroy
      @video = Video.find(params[:id])
      @video.destroy
      redirect_to admin_videos_path, notice: 'Video removed'
    end

    def reorder
      params[:video].each.with_index do |id, index|
        Video.find(id).update(position: index + 1)
      end
      render status: :ok, body: nil
    end

    private

    def video_params
      params.require(:video).permit(:url, :name, :tag_list)
    end
  end
end
