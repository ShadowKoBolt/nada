module Admin
  class VideosController < BaseController
    def index
      @videos = Video.all
    end

    def new
      @video = Video.new
    end

    def create
      @video = Video.new(video_params)
      if @video.save
        redirect_to admin_videos_path(notice: 'Video added')
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
        redirect_to admin_videos_path(notice: 'Video updated')
      else
        render action: :edit
      end
    end

    private

    def video_params
      params.require(:video).permit(:url, :name)
    end
  end
end
