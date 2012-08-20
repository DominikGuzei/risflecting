module ApplicationHelper

  def page_title(title)
    content_for :page_title do title end
  end

  def page_stylesheet(path, options)
    content_for :stylesheet_includes do
      stylesheet_link_tag path, options
    end
  end

  def page_javascript(path)
    content_for :javascript_includes do
      javascript_include_tag path
    end
  end

  def bootstrap_flash_messages
    flash_messages = []
    flash.each do |type, message|
      type = :info     if type == :notice
      type = :warning  if type == :alert
      text = content_tag(:div, message, :class => "flash-message alert alert-#{type.to_s}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
end
