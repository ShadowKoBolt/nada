class AddTeachingLocationsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :teaching_locations, :string
  end
end
