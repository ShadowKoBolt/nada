module Admin
  class TeamsController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:reorder]

    def index
      @teams = Team.all
    end

    def new
      @team = Team.new
    end

    def create
      @team = Team.new(team_params)
      if @team.save
        redirect_to admin_teams_path, notice: 'Team added'
      else
        render action: :new
      end
    end

    def edit
      @team= Team.find(params[:id])
    end

    def update
      @team= Team.find(params[:id])
      if @team.update(team_params)
        redirect_to admin_teams_path, notice: 'Team updated'
      else
        render action: :edit
      end
    end

    def destroy
      @team= Team.find(params[:id])
      @team.destroy
      redirect_to admin_teams_path, notice: 'Team removed'
    end

    def reorder
      params[:team].each.with_index do |id, index|
        Team.find(id).update(position: index + 1)
      end
      render status: :ok, body: nil
    end

    private

    def team_params
      params.require(:team).permit(:name)
    end
  end
end
