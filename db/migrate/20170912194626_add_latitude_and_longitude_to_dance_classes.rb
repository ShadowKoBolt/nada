class AddLatitudeAndLongitudeToDanceClasses < ActiveRecord::Migration[5.1]
  def change
    add_column :dance_classes, :latitude, :float
    add_column :dance_classes, :longitude, :float
  end
end
