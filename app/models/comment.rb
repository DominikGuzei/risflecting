class Comment < ActiveRecord::Base
  belongs_to :post, :touch => true
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id

  attr_accessible :text
  validates :text, :presence => true
end
