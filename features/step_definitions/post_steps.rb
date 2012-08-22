#encoding: utf-8

Given /^I am on the posts overview page$/ do
  visit intern_posts_path
end

Then /^I want to see the form to create a new question$/ do
  current_path.should == new_intern_post_path
end

Given /^I visit the form to create a new question$/ do
  visit new_intern_post_path
end

When /^I fill in all fields of the question form$/ do
  fill_in 'post_title', :with => 'A new question'
  fill_in 'post_body', :with => 'Some big problems ...'
end

Then /^I want some feedback that the question was created successfully$/ do
  page.should have_selector('.flash-message.alert-success')
end

Then /^I want to see the newly created question$/ do
  page.should have_content 'A new question'
  page.should have_content 'Some big problems ...'
end

Given /^there is a question$/ do
  @author = FactoryGirl.create :user
  @post_data = { :title => 'Stupid title', :body => 'A question or message ...', :author => @author }
  @post = FactoryGirl.create :post, @post_data
end

Then /^I want to see the title and author of the question$/ do
  page.should have_content @post_data[:title]
  page.should have_content @post_data[:author].surname
end

Given /^there are (\d+) questions$/ do |amount_of_posts|
  FactoryGirl.create_list :post, amount_of_posts.to_i
end

Given /^I am on the questions and messages page$/ do
  visit intern_posts_path
end

Then /^I want to see a list containing (\d+) items$/ do |amount_of_posts|
  find('#posts-list').all('li').count.should == amount_of_posts.to_i
end

When /^I click on the title of the question$/ do
  click_on @post_data[:title]
end

Then /^I want to see the details of the question$/ do
  page.should have_content @post_data[:title]
  page.should have_content @post_data[:body]
  page.should have_content @author[:surname]
  page.should have_content @author[:forename]
end

When /^I click on the first question$/ do
  click_on Post.first.title
end

Then /^I want to see a list containing (\d+) recent alternative questions$/ do |amount_of_list_items|
  find('#recent-alternative-questions').all('li').count.should == amount_of_list_items.to_i
end

Given /^I am on the question details page$/ do
  visit intern_post_path @post
end

When /^I fill in the comment form$/ do
  @comment_data = { :text => 'A new refreshing comment.' }
  fill_in 'comment_text', :with => @comment_data[:text]
end

Given /^the question has (\d+) comments$/ do |amount_of_comments|
  user = FactoryGirl.create :user
  @post.comments = FactoryGirl.create_list :comment, amount_of_comments.to_i, :author => user, :post => @post
end

Then /^I want to see (\d+) comments listed$/ do |amount_of_comments|
  find('#comments-list').all('li').count == amount_of_comments
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
  @post_data = { :title => 'Stupid title', :body => 'A question or message ...', :author => @current_user }
  @post = FactoryGirl.create :post, @post_data
end

Then /^I want to see the attachment upload form$/ do
  page.should have_content 'Neue Datei hinzufügen'
end

When /^I add an attachment$/ do
  attach_file('attachment_file', "#{Rails.root}/features/fixtures/test.png")
end

When /^I upload the attachment$/ do
  click_on 'Datei hinzufügen'
end

Then /^I want some feedback that the attachment was successfully uploaded$/ do
  page.should have_selector('.flash-message.alert-success')
end

Then /^I want to be on the question details page$/ do
  current_path.should == intern_post_path(@post)
end

When /^I enter a URL in the comment field$/ do
  fill_in 'comment_text', :with => 'www.example.com'
end

Then /^I want the URL in the saved comment to be clickable$/ do
  page.find_link('www.example.com').should be_visible
end

When /^I enter a URL in the description field$/ do
  fill_in 'post_body', :with => 'https://www.example.com'
end

Then /^I want the entered URL in the question details to be clickable$/ do
  page.find_link('https://www.example.com').should be_visible

Given /^the question has (\d+) attached files?$/ do |amount_of_attachments|
  FactoryGirl.create_list :attachment, amount_of_attachments.to_i, :attachable => @post
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
