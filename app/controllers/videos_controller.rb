# frozen_string_literal: true

class VideosController < ApplicationController
  def index
    @pagy, @videos = pagy(Video.includes(:user), page: page, items: per_page)
  end
end
