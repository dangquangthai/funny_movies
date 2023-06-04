# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  layout false

  def index
    @notifications = current_user.notifications.not_notified_yet

    respond_to do |format|
      format.html
    end
  end
end
