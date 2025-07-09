class Poll < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes , message: 'kích thước phải nhỏ hơn 5MB' }, allow_nil: true

  belongs_to :user

  has_many :options, inverse_of: :poll, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank
end
