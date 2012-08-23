class Project < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id
  has_many :attachments, :as => :attachable

  attr_accessible :body, :title
  validates :title, :body, :presence => true
end
