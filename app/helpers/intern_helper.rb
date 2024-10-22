module InternHelper

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

  def generate_file_type_icon extension
    icon_type = 'image'    if /\.(jpg|jpeg|png|gif|psd|bmp|tiff)/i =~ extension
    icon_type = 'document' if /\.(pdf|doc|docx|odt|txt|pages|keynote|ppt|pptx)/i =~ extension
    icon_type = 'table'    if /\.(xls|xlsx|numbers|csv|ods)/i =~ extension
    icon_type = 'audio'    if /\.(mp3|wav)/i =~ extension
    icon_type = 'video'    if /\.(mp4|ogg|webv|flv|avi|mpg|mpeg)/i =~ extension
    icon_type = 'archive'  if /\.(zip|7z|rar|gzip|tar|gz)/i =~ extension
    icon_type = 'unknown'  if icon_type.nil?

    image_tag asset_path("intern/file-types/#{icon_type.downcase}.png")
  end

  def avatar_url file, version = :normal
    if file.url.blank?
      asset_path "intern/#{['default', 'avatar', version.to_s].join('-')}.jpg"
    else
      file = file.send(version.to_sym) unless version == :normal
      file.url
    end
  end

  def avatar_image_tag avatar, version, options = {}
    options.symbolize_keys!
    options[:class] = [(options[:class] ||= ''), 'rounded'].join(' ')

    image_tag avatar_url(avatar, version), :alt => options[:alt], :class => options[:class], :size => AvatarUploader.get_version_dimension(version).join('x')
  end

  def truncate_list_title text, length
    truncate text, :length => length, :separator => ' ', :omission => ' ...'
  end
end
