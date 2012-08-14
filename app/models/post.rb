class Post < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id

  attr_accessible :body, :title
  validates :title, :body, :presence => true
end
