class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, :movie_id, :content, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
end
