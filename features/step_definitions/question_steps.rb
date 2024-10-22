# encoding: utf-8

Given /^I am on the questions overview page$/ do
  visit intern_questions_path
end

Then /^I want to see the form to create a new question$/ do
  current_path.should == new_intern_question_path
end

Given /^I visit the form to create a new question$/ do
  visit new_intern_question_path
end

When /^I fill in all fields of the question form$/ do
  fill_in 'question_title', :with => 'A new question'
  fill_in 'question_body', :with => 'Some big problems ...'
end

Then /^I want to see the newly created question$/ do
  page.should have_content 'A new question'
  page.should have_content 'Some big problems ...'
end

Given /^there is a question$/ do
  @author = FactoryGirl.create :user
  @question_data = { :title => 'Stupid title', :body => 'A question or message ...', :author => @author }
  @question = FactoryGirl.create :question, @question_data
end

Then /^I want to see the title and author of the question$/ do
  page.should have_content @question_data[:title]
  page.should have_content @question_data[:author].surname
end

Given /^there are (\d+) questions$/ do |amount_of_questions|
  FactoryGirl.create_list :question, amount_of_questions.to_i
end

Given /^I am on the questions and messages page$/ do
  visit intern_questions_path
end

Then /^I want to see a list containing (\d+) items$/ do |amount_of_questions|
  find('#questions-list').all('li').count.should == amount_of_questions.to_i
end

When /^I click on the title of the question$/ do
  click_on @question_data[:title]
end

Then /^I want to see the details of the question$/ do
  page.should have_content @question_data[:title]
  page.should have_content @question_data[:body]
  page.should have_content @author[:surname]
  page.should have_content @author[:forename]
end

When /^I click on the first question$/ do
  first(:link, Question.first.title).click
end

Then /^I want to see a list containing (\d+) recent alternative questions$/ do |amount_of_list_items|
  find('#recent-alternative-questions').all('li').count.should == amount_of_list_items.to_i
end

Given /^I am on the question details page$/ do
  visit intern_question_path @question
end

When /^I fill in the comment form$/ do
  @comment_data = { :text => 'A new refreshing comment.' }
  fill_in 'comment_text', :with => @comment_data[:text]
end

Given /^the question has (\d+) comments$/ do |amount_of_comments|
  user = FactoryGirl.create :user
  @question.comments = FactoryGirl.create_list :comment, amount_of_comments.to_i, :author => user, :question => @question
end

Then /^I want to see (\d+) comments listed$/ do |amount_of_comments|
  find('#comments-list').all('li').count.should == amount_of_comments.to_i
end

When /^I add a comment$/ do
  step 'I fill in the comment form'
  step 'I save the comment'
end

Then /^I want to see my comment in the list$/ do
  page.should have_content @comment_data[:text]
end

Given /^I navigate to the next questions page$/ do
  click_on 'Nächste'
end

Given /^there is one question from a different user$/ do
  step 'there is a question'
end

Then /^I do not want to see the attachment upload form$/ do
  page.should_not have_content 'Neue Datei hinzufügen'
end

Given /^there is one question from myself$/ do
  @question_data = { :title => 'Stupid title', :body => 'A question or message ...', :author => @current_user }
  @question = FactoryGirl.create :question, @question_data
end

Then /^I want to see the attachment upload form$/ do
  page.should have_content 'Neue Datei hinzufügen'
end

When /^I add an attachment$/ do
  attach_file 'attachment_file', "#{Rails.root}/features/fixtures/test.png"
end

When /^(I upload the attachment|I click the upload button)$/ do |action|
  within('#attachment-form') { click_on 'Hochladen' }
end

When /^I forget choose a file$/ do
  # do nothing
end

Then /^I want some feedback that the attachment was successfully uploaded$/ do
  page.should have_selector '.flash-message.alert-success'
end

Then /^I want some feedback that the file is missing$/ do
  within('#attachment-form') do
    should have_selector '.alert.alert-error', text: 'Achtung! Beim Versuch die Datei hochzuladen sind Fehler aufgetreten.'
    should have_selector '.error .file-input + span', text: I18n.t('errors.messages.blank')
  end
end

Then /^I want to be on the question details page$/ do
  current_path.should == intern_question_path(@question)
end

When /^I enter a URL in the comment field$/ do
  fill_in 'comment_text', :with => 'www.example.com'
end

Then /^I want the URL in the saved comment to be clickable$/ do
  find_link('www.example.com').should be_visible
end

When /^I enter a URL in the description field$/ do
  fill_in 'question_body', :with => 'https://www.example.com'
end

Then /^I want the entered URL in the question details to be clickable$/ do
  within('#question-details') { find_link('https://www.example.com').should be_visible }
end

Given /^the question has (\d+) attached files?$/ do |amount_of_attachments|
  FactoryGirl.create_list :attachment, amount_of_attachments.to_i, :attachable => @question
end

Then /^I want to see a list containing (\d+) linked file names$/ do |amount_of_files|
  find('#attachments-list').all('li').count.should == amount_of_files.to_i
  find('#attachments-list').all('a').count.should == amount_of_files.to_i
end

When /^I click on the filename in the attachments section$/ do
  find('#attachments-list a').click
end

Then /^I want to receive a file$/ do
  # test file is a PNG image - this is not a proper solution
  page.response_headers['Content-Type'].should == 'image/png'
end

Then /^I want to see that the question has (\d+) comments$/ do |amount_of_comments|
  page.should have_content (amount_of_comments + ' Kommentare')
end

Then /^I want to see the form to edit the question$/ do
  current_path.should == edit_intern_question_path(@question)
end

Given /^I am on the question edit page$/ do
  visit edit_intern_question_path(@question)
end

When /^I change the question´s title and description$/ do
  @changed_question = {
    :title => 'Changed Title',
    :body => 'Changed Description'
  }

  fill_in 'question_title', :with => @changed_question[:title]
  fill_in 'question_body', :with => @changed_question[:body]
end

When /^I remove the question´s title and description$/ do
  fill_in 'question_title', :with => ''
  fill_in 'question_body', :with => ''
end

Then /^I want to see the changes on the question details page$/ do
  page.should have_content @changed_question[:title]
  page.should have_content @changed_question[:body]
end

When /^I change none of the question information$/ do
  # do nothing
end

When /^I save the question anyway$/ do
  step 'I save the changes'
end

Then /^I want to see the existing question information on the question details page$/ do
  page.should have_content @question[:title]
  page.should have_content @question[:body]
end

Then /^I want to see a trash bin next to the attachment$/ do
  within('#attachments-list') { should have_selector('.trash') }
end

Then /^I do not want to see a trash bin next to the attachment$/ do
  within('#attachments-list') { should_not have_selector('.trash') }
end

When /^I click the trash bin next to the attachment$/ do
  within('#attachments-list') { find('.trash').click }
end

Then /^I want the attachment to be removed from the list$/ do
  page.should_not have_selector '#attachments-list'
end
