class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :comment, length: {minimum: 5, maximum: 500}
end
