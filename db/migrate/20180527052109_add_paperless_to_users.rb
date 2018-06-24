class AddPaperlessToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :paperless, :boolean, default: false
  end
end
