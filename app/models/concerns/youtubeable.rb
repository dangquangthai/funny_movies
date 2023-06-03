# frozen_string_literal: true

module Youtubeable
  extend ActiveSupport::Concern

  # https://regex101.com/r/zhaTXK/1
  YOUTUBE_URL_REGEX = %r{(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})}

  included do
    scope :youtube, -> { where(source: 'youtube') }

    validates :source_url, format: {
      with: YOUTUBE_URL_REGEX,
      message: 'must be a YouTube URL'
    }, if: :youtube?

    def youtube?
      source == 'youtube'
    end

    def fetch_youtube_metadata
      self.source_id = extract_youtube_id

      return if source_id.blank?

      service = Integration::Youtube.new(source_id: source_id)
      service.fetch
      self.title = service.title
      self.description = service.description
    rescue StandardError
      errors.add(:source_url, 'is not a valid YouTube URL')
    end

    protected

    def extract_youtube_id
      return if source_url.blank?

      YOUTUBE_URL_REGEX.match(source_url).try(:captures)&.first
    end
  end
end
