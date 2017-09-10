module Admin
  class TeamMembersController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:reorder]

    def index
      @team_members = TeamMember.all
    end

    def new
      @team_member = TeamMember.new
    end

    def create
      @team_member = TeamMember.new(team_member_params)
      if @team_member.save
        redirect_to admin_team_members_path, notice: 'Team member added'
      else
        render action: :new
      end
    end

    def edit
      @team_member = TeamMember.find(params[:id])
    end

    def update
      @team_member = TeamMember.find(params[:id])
      if @team_member.update(team_member_params)
        redirect_to admin_team_members_path, notice: 'Team member updated'
      else
        render action: :edit
      end
    end

    def destroy
      @team_member = TeamMember.find(params[:id])
      @team_member.destroy
      redirect_to admin_team_members_path, notice: 'Team member removed'
    end

    def reorder
      params['team-member'].each.with_index do |id, index|
        TeamMember.find(id).update(position: index + 1)
      end
      render status: :ok, body: nil
    end

    private

    def team_member_params
      params.require(:team_member).permit(:name, :role, :image, :image_credit, :description, :contact_details, :team_id)
    end
  end
end
