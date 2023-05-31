module ApplicationHelper
  def material_icon(icons, **options)
    options[:class] = "#{options[:class]} material-icons material-symbols-outlined".strip

    content_tag :span, icons, options
  end
end
