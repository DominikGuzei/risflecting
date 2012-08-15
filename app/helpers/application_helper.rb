module ApplicationHelper
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
