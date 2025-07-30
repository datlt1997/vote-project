class Poll < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes , message: 'kích thước phải nhỏ hơn 5MB' }, allow_nil: true

  belongs_to :user

  has_many :votes, dependent: :destroy
  has_many :options, inverse_of: :poll, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank

  def self.check_and_send_ended_emails
    ended_polls = where("expires_at IS NOT NULL AND expires_at <= ? AND (ended_email_sent = ? or ended_email_sent IS NULL)", Time.current, false)

    ended_polls.find_each do |poll|
      # Gửi email đến tất cả người đã vote
      users = poll.options.includes(votes: :user).flat_map { |opt| opt.votes.map(&:user) }.uniq

      users.each do |user|
        PollMailer.poll_ended_email(poll, user).deliver_now
      end

      # Cập nhật trạng thái đã gửi mail (nếu có field)
      poll.update(ended_email_sent: true)
    end
  end
end
