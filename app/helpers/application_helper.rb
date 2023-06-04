# frozen_string_literal: true

module ApplicationHelper
  include Turbo::StreamsHelper
  include Turbo::FramesHelper

  def material_icon(icons, **options)
    options[:class] = "#{options[:class]} material-icons material-symbols-outlined".strip

    content_tag :span, icons, options
  end

  def turbo_redirect_tag(url)
    turbo_stream.replace('redirect-tag') do
      content_tag :div, nil, data: { controller: 'redirect', url: url }
    end
  end
end
