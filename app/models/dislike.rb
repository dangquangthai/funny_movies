class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :dislikeable, polymorphic: true, counter_cache: :dislikes_count

  validates :user, :dislikeable, presence: true
  validates :user_id, uniqueness: { 
    scope: [:dislikeable_type, :dislikeable_id],
    message: 'Video has already been disliked'
  }
end
