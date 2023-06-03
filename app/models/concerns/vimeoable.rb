# frozen_string_literal: true

module Vimeoable
  extend ActiveSupport::Concern

  # VIMEO_URL_REGEX = regex here
  # EXTRACT_VIMEO_ID_REGEX = regex here

  included do
    def vimeo?
      source == 'vimeo'
    end

    def extract_vimeo_id(_url)
      'not_implemented_yet' # FIXME: implement this method
    end
  end
end
