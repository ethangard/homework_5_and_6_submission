class Comment < ApplicationRecord
  belongs_to :post
  validates :comment, length: {minimum: 5, maximum: 500}
end
