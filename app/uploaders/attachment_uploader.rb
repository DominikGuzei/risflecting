# encoding: utf-8

require 'carrierwave/processing/mime_types'

class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
