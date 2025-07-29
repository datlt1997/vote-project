class Option < ApplicationRecord
  validates :content, presence: true

  belongs_to :poll
  has_many :votes
end
