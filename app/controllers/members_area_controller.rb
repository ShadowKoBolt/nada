class MembersAreaController < BaseController
  def show
    @latest_videos = Video.limit(3)
    @latest_magazines = Magazine.limit(4)
  end
end
