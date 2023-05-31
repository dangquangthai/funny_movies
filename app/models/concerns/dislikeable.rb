# frozen_string_literal: true

module Dislikeable
  extend ActiveSupport::Concern

  included do
    has_many :dislikes, as: :dislikeable, dependent: :destroy
  end
end
