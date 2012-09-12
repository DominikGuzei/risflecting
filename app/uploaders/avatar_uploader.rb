# encoding: utf-8

require 'carrierwave/processing/mime_types'

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick

  @@version_dimensions = {
    :normal => [220, 300],
    :small  => [56, 56],
    :tiny   => [20, 20]
  }

  process :set_content_type
  process :resize_to_fill => @@version_dimensions[:normal]
  process :convert => 'jpg'

  version(:small) { process :resize_to_fill => @@version_dimensions[:small] }
  version(:tiny) { process :resize_to_fill => @@version_dimensions[:tiny] }

  def filename
    super != nil ? super.split('.').first + '.jpg' : super
  end

  def extension_white_list
    %w(jpg jpeg gif png tif tiff bmp)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def self.get_version_dimension version
    @@version_dimensions[version.to_sym]
  end

  def filename
    "#{file_timestamp}_#{original_filename}" if original_filename.present?
  end

  protected
  def file_timestamp
    variable = :"@#{mounted_as}_file_timestamp"
    model.instance_variable_get(variable) or model.instance_variable_set(variable, model.updated_at.to_i)
  end
end
