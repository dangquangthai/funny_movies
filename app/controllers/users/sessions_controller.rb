# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token, only: %i[destroy]
    layout false, only: %i[create destroy]

    def create; end

    protected

    def respond_to_on_destroy
      respond_to do |format|
        format.html
      end
    end
  end
end
