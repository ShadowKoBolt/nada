class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url
      t.integer :position, default: -1
      t.string :thumbnail_url
      t.timestamps
    end
  end
end
