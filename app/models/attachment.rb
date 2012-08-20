class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  attr_accessible :file

  validates :file, :presence => true

  mount_uploader :file, AttachmentUploader
end
