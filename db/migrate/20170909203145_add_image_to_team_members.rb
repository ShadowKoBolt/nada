class AddImageToTeamMembers < ActiveRecord::Migration[5.1]
  def up
    add_attachment :team_members, :image
  end

  def down
    remove_attachment :team_members, :image
  end
end
