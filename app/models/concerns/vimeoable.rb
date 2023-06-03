# frozen_string_literal: true

module Vimeoable
  extend ActiveSupport::Concern

  # VIMEO_URL_REGEX = regex here

  included do
    def vimeo?
      source == 'vimeo'
    end
  end
end
