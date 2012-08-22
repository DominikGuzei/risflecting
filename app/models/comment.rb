class Comment < ActiveRecord::Base
  belongs_to :question, :touch => true
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id

  attr_accessible :text, :author
  validates :text, :user_id, :question_id, :presence => true
end
