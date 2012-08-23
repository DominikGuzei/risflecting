# encoding: utf-8

require 'carrierwave/processing/mime_types'

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick

  process :set_content_type
  process :resize_to_fill => [220, 300]
  process :convert => 'jpg'

  version(:small) { process :resize_to_fill => [48, 48] }
  version(:tiny) { process :resize_to_fill => [20, 20] }

  def filename
    super != nil ? super.split('.').first + '.jpg' : super
  end

  def extension_white_list
    %w(jpg jpeg gif png tif tiff bmp)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
