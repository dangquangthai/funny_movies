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

  def source_url=(url)
    self.source_id = extract_source_id(url)
    # self.source = extract_source(url)
    super
  end

  protected

  def extract_source_id(url)
    {
      'youtube' => extract_youtube_id(url),
      'vimeo' => extract_vimeo_id(url)
    }.fetch(source)
  end

  def extract_source(url)
    # FIXME: we should do same way as extract_source_id
  end
end
