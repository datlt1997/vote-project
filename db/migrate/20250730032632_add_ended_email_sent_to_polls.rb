class AddEndedEmailSentToPolls < ActiveRecord::Migration[7.1]
  def change
    add_column :polls, :ended_email_sent, :boolean
  end
end
