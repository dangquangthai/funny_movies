# frozen_string_literal: true

class Video < ApplicationRecord
  include Likeable
  include Dislikeable
  include Youtubeable
  include Vimeoable

  SOURCES = %w[youtube vimeo].freeze

  validates :source_url, presence: true
  validates :source, inclusion: { in: SOURCES }
  validates :source_id, uniqueness: { scope: %i[source user_id], message: 'has already been shared' }

  belongs_to :user

  after_create_commit { SharedVideoJob.perform_async(id) }
end
