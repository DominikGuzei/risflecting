require 'spec_helper'

describe Question do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should have_many :comments }
  it { should have_many :attachments }

  describe '#recent_alternative_questions' do
    it 'should get a maximum of 5 alternative questions' do
      FactoryGirl.create_list :question, 10

      Question.first.recent_alternative_questions.length.should be 5
    end

    it 'should not include itself' do
      FactoryGirl.create_list :question, 5

      questions = Question.first.recent_alternative_questions

      questions.length.should be 4
      questions.include?(Question.first).should be false
    end

    it 'should include the most recent questions' do
      FactoryGirl.create_list :question, 10

      Question.first.recent_alternative_questions.should =~ Question.limit(5).order('updated_at DESC')
    end
  end
end
