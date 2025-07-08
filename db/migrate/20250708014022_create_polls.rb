class CreatePolls < ActiveRecord::Migration[7.1]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :expires_at
      t.boolean :allows_multiple, default: false
      t.boolean :anonymous, default: false
      t.references :user, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
