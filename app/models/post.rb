class Post < ApplicationRecord

    has_many :comments, dependent: :destroy

    validates :title, :body, presence: true
    validates :body, length: {minimum: 50}
end
