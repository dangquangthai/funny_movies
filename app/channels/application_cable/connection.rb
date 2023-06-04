# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection if env['warden']&.user.blank?

      self.current_user = env['warden']&.user
    end
  end
end
