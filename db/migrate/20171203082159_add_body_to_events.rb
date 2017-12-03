class AddBodyToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :body, :text
  end
end
