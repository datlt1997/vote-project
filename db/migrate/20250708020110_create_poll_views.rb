class CreatePollViews < ActiveRecord::Migration[7.1]
  def change
    create_table :poll_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :poll, null: false, foreign_key: true
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
