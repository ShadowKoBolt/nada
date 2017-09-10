class AddTeamToTeamMembers < ActiveRecord::Migration[5.1]
  def change
    add_reference :team_members, :team, foreign_key: true
  end
end
