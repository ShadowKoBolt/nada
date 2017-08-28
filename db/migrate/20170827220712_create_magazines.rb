class CreateMagazines < ActiveRecord::Migration[5.1]
  def change
    create_table :magazines do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
