class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :address_line_3, :string
    add_column :users, :city, :string
    add_column :users, :region, :string
    add_column :users, :postcode, :string
    add_column :users, :country, :string
    add_column :users, :notes, :text
  end
end
