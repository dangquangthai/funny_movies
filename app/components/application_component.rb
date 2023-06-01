# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include ApplicationHelper

  delegate :current_user, :current_profile, to: Current
end
