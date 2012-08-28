class Document < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'User', :foreign_key => :user_id

  mount_uploader :asset, AssetUploader
  attr_accessible :title, :asset, :asset_cache

  validates :title, :asset, :presence => true
end
