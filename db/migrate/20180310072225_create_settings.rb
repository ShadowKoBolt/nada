class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :dance_class_update_emails

      t.timestamps
    end
  end
end
