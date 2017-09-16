class AddJoinDateRenewalDateStatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :join_date, :date
    add_column :users, :renewal_date, :date
    add_column :users, :status, :string
  end
end
