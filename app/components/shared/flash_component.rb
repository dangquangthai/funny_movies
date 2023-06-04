# frozen_string_literal: true

module Shared
  class FlashComponent < ApplicationComponent
    def self.new_from_notification(notification:)
      new(type: 'notice', message: notification.to_flash_message)
    end

    def initialize(type:, message:)
      @message = message
      @type = type.to_s
    end

    attr_reader :type, :message

    def css_class
      class_names('pointer-events-auto w-full rounded-md shadow-md p-2 md:p-4 flex gap-2 items-center',
                  'bg-green-300 text-green-900' => type == 'notice',
                  'bg-red-300 text-red-900' => type == 'error',
                  'bg-yellow-300 text-yellow-900' => type == 'alert')
    end
  end
end
