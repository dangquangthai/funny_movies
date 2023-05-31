module Pagination
  extend ActiveSupport::Concern

  included do
    include Pagy::Backend
  
    def page
      @page ||= params[:page]&.to_i || 1
    end

    def per_page
      @per_page ||= params[:per_page]&.to_i || Pagy::DEFAULT[:items]
    end
  end
end
