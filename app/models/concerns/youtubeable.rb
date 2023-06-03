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
      return unless valid?

      if youtube_integrator.perform
        build_youtube_attibutes
      else
        errors.add(:source_url, 'is not a valid YouTube URL')
      end
    rescue StandardError
      errors.add(:source_url, 'is not a valid YouTube URL')
    end

    protected

    def youtube_integrator
      @youtube_integrator ||= Integration::Youtube.new(source_url: source_url)
    end

    def build_youtube_attibutes
      self.source_id = youtube_integrator.source_id
      self.title = youtube_integrator.title
      self.description = youtube_integrator.description
    end
  end
end
