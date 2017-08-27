class MembersAreaController < ApplicationController
  before_action :authenticate_user!

  def show
    @latest_videos = Video.limit(3)
  end
end
