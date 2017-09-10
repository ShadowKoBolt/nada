class CreateTeamMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members do |t|
      t.string :name
      t.integer :position
      t.string :role
      t.text :description
      t.text :contact_details

      t.timestamps
    end
  end
end
