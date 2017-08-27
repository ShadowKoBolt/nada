class MembersAreaController < BaseController
  def show
    @latest_videos = Video.limit(3)
  end
end
