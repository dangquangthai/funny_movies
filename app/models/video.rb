# frozen_string_literal: true

class Video < ApplicationRecord
  include Likeable
  include Dislikeable
  include Youtubeable
  include Vimeoable

  SOURCES = %w[youtube vimeo].freeze

  validates :source_url, presence: true
  validates :source, inclusion: { in: SOURCES }

  belongs_to :user
end
