# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @pagy, @videos = pagy(Video.includes(:user), page: page, items: per_page)
  end

  def new
    @video = current_user.videos.youtube.build
  end

  def create
    @video = current_user.videos.build(video_params)
    @video.fetch_youtube_metadata

    respond_to do |format|
      format.html do
        flash[:notice] = 'Video shared successfully' if @video.save
        render layout: false
      end
    end
  end

  protected

  def video_params
    params.require(:video).permit(:source, :source_url)
  end
end
