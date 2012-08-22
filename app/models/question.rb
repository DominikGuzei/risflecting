class Question < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => :user_id
  has_many :comments
  has_many :attachments, :as => :attachable

  attr_accessible :body, :title
  validates :title, :body, :presence => true

  def recent_alternative_questions
    Question.where('id <> ?' , self.id).order('updated_at DESC').limit(5)
  end
end
