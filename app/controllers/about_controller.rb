class AboutController < ApplicationController
  def show
    @ungrouped_team_members = TeamMember.where(team: nil)
    @teams = Team.all.includes(:team_members)
  end
end
