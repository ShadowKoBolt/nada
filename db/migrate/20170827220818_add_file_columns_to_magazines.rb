class AddFileColumnsToMagazines < ActiveRecord::Migration[5.1]
  def up
    add_attachment :magazines, :file
  end

  def down
    remove_attachment :magazines, :file
  end
end
