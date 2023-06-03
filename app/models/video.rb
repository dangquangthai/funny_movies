# frozen_string_literal: true

class Video < ApplicationRecord
  include Likeable
  include Dislikeable
  include Youtubeable
  include Vimeoable

  SOURCES = %w[youtube vimeo].freeze

  validates :source, :source_id, :source_url, :title, presence: true
  validates :source, inclusion: { in: SOURCES }

  belongs_to :user
end
