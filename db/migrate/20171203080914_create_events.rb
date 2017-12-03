class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :location
      t.boolean :featured
      t.string :facebook_url
      t.integer :position
      t.boolean :published

      t.timestamps
    end
  end
end
