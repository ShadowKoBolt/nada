class CreateDanceClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :dance_classes do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :city
      t.string :region
      t.string :postcode
      t.string :level
      t.string :style
      t.text :description

      t.timestamps
    end
  end
end
