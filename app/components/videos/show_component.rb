# frozen_string_literal: true

module Videos
  class ShowComponent < ApplicationComponent
    def initialize(video:)
      @video = video
    end

    attr_reader :video

    delegate :youtube?,
             :vimeo?,
             :source_id,
             :title,
             :description,
             :likes_count,
             :dislikes_count,
             :user,
             to: :video
  end
end
