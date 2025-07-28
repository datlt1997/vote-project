class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :role, default: 0
      t.string :user_name, null: false
      t.string :avatar

      t.timestamps
    end
  end
end
