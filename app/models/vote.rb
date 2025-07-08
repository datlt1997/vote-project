class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :option
  belongs_to :user, optional: true
end
