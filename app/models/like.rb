class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count

  validates :user, :likeable, presence: true
  validates :user_id, uniqueness: { 
    scope: [:likeable_type, :likeable_id],
    message: 'Video has already been liked'
  }
end
