class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :message
      t.references :user, null: false, foreign_key: true
      t.boolean :is_read

      t.timestamps
    end
  end
end
