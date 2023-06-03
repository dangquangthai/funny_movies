# frozen_string_literal: true

module Shared
  class NotificationComponent < ApplicationComponent
    def initialize(flash:)
      @flash = flash
    end

    attr_reader :flash

    def css_class(type)
      class_names('pointer-events-auto w-full rounded-md shadow-md p-2 md:p-4 flex gap-2 items-center',
                  'bg-green-300 text-green-900' => type == 'notice',
                  'bg-red-300 text-red-900' => type == 'error',
                  'bg-yellow-300 text-yellow-900' => type == 'alert')
    end
  end
end
