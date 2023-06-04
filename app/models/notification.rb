# frozen_string_literal: true

class Notification < ApplicationRecord
  ACTIONS = %w[shared_a_video].freeze

  belongs_to :user
  belongs_to :whodunit, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  validates :user, :whodunit, :action, :notifiable, presence: true
  validates :action, inclusion: { in: ACTIONS }

  scope :not_notified_yet, -> { where(notified_at: nil) }

  after_create_commit { NotificationBroadcastJob.perform_async(id) }

  delegate :title, to: :notifiable

  def to_flash_message
    case action
    when 'shared_a_video'
      "#{whodunit.email} shared <strong>#{title}</strong> video with you"
    end
  end

  def broadcast_message
    {
      id: id,
      user_id: user_id.to_s,
      type: 'notification'
    }
  end

  def mark_as_notified!
    update!(notified_at: Time.current)
  end
end
