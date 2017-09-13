class AddTeacherToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :teacher, :boolean
    add_column :users, :teacher_email, :string
    add_column :users, :teacher_phone, :string
  end
end
