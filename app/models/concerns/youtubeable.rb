# frozen_string_literal: true

module Youtubeable
  extend ActiveSupport::Concern

  # https://regex101.com/r/zhaTXK/1
  YOUTUBE_URL_REGEX = %r{(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})}

  # https://gist.github.com/afeld/1254889
  EXTRACT_YOUTUBE_ID_REGEX = %r{(?<!href=")https?://(www\.)?(?:youtube(?:-nocookie)?\.com/(?:[^/\n\s]+/\S+/|(?:v|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/)([a-zA-Z0-9_-]{11})(\?[a-z=/-_]*)?}i

  included do
    validates :source_url, format: {
      with: YOUTUBE_URL_REGEX,
      message: 'must be a valid YouTube URL'
    }, if: :youtube?

    def youtube?
      source == 'youtube'
    end

    def extract_youtube_id(url)
      EXTRACT_YOUTUBE_ID_REGEX.match(url).try(:captures).try(:reverse).try(:second)
    end
  end
end
