class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true, :touch => true

  before_save :save_size

  attr_accessible :file

  validates :file, :presence => true

  mount_uploader :file, AttachmentUploader

  private
  def save_size
    self.size = file.file.size
  end
end
