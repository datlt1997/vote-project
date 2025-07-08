class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true, null: true
      t.references :option, null: false, foreign_key: true
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
