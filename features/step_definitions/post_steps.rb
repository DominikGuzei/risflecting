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
  amount_of_posts = amount_of_posts.to_i
  author = FactoryGirl.create :user

  while amount_of_posts > 0 do
    FactoryGirl.create :post, :author => author
    amount_of_posts -= 1
  end
end

Given /^I am on the questions and messages page$/ do
  visit intern_posts_path
end

Then /^I want to see a list containing (\d+) items$/ do |amount_of_posts|
  find('#posts-list').all('li').count == amount_of_posts.to_i
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

Given /^I am on the question details page$/ do
  visit intern_post_path @post
end

When /^I fill in the comment form$/ do
  fill_in 'comment_text', :with => 'A new refreshing comment.'
end
