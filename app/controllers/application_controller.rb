# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include InitializeComponentContext
  include Pagination
  include LazyCustomDeviseRegistration
end
