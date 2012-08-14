Given /^I am on the posts overview page$/ do
  visit intern_posts_path
end

Then /^I want to see the form to create a new question$/ do
  current_path.should == new_intern_post_path
end

Given /^I visit the form to create a new question$/ do
  visit new_intern_post_path
end

When /^I save the question$/ do
  click_on 'submit'
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
