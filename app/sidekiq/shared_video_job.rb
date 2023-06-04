# frozen_string_literal: true

class SharedVideoJob
  include Sidekiq::Job

  def perform(video_id)
    video = Video.find(video_id)

    # should notify to only followers, but in this case we don't have followers
    User.where.not(id: video.user_id).each do |user|
      user.notifications.create!(whodunit: video.user, notifiable: video, action: 'shared_a_video')
    end
  end
end
