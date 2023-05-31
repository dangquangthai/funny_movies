# frozen_string_literal: true

class Dislike < ApplicationRecord
  belongs_to :user
  belongs_to :dislikeable, polymorphic: true, counter_cache: :dislikes_count

  validates :user, :dislikeable, presence: true
  validates :user_id, uniqueness: {
    scope: %i[dislikeable_type dislikeable_id],
    message: 'Video has already been disliked'
  }
end
