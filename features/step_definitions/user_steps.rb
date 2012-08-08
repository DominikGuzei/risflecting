Given /^I am sign in as a user$/ do
  email = 'test@test.com'
  password = 'testtest'
  user = User.new :email => email,
                  :password => password,
                  :password_confirmation => password,
                  :forename => 'Test',
                  :surname => 'Tester',
                  :phone => '0900'

  user.confirmed_at = Time.now
  user.save!

  visit '/intern'
  fill_in 'intern_user_email', :with => email
  fill_in 'intern_user_password', :with => password
  click_on 'submit'
end

Given /^I am signed out$/ do
  visit '/intern/users/sign_out'
end

Given /^I visit the form to create a new user$/ do
  visit new_intern_account_path
end

Given /^I fill in a correct email address$/ do
  fill_in 'user_email', :with => 'invite@test.com'
end

Given /^I invite the user$/ do
  click_on 'submit'
end

Then /^I want to see feedback that the user was invited$/ do
  page.should have_selector '.flash-message.alert-success'
end

Then /^I want to see the form to create a new user again$/ do
  current_path.should == new_intern_account_path
end

Then /^I want to see an error$/ do
  page.should have_selector '.flash-message.alert-error'
end

Given /^I fill an already invited email address$/ do
  fill_in 'user_email', :with => User.first.email
end

Then /^the user should have received an email with instructions$/ do
  step '"invite@test.com" should receive an email'
end

Given /^I have an invitation email$/ do
  user = User.new :email => 'invite@test.com'
  user.save :validate => false
end

When /^I open my invitation email$/ do
  open_email 'invite@test.com'
end

When /^I fill in my profile details$/ do
  fill_in 'intern_user_forename', :with => 'Walter'
  fill_in 'intern_user_surname', :with => 'White'
  fill_in 'intern_user_phone', :with => '42'
  fill_in 'intern_user_password', :with => 'password'
  fill_in 'intern_user_password_confirmation', :with => 'password'
end

When /^I confirm my profile$/ do
  click_on 'submit'
end

Then /^I should be able to access the internal website$/ do
  current_path.should == intern_root_path
end

Then /^I should be redirected to the internal website$/ do
  current_path.should == intern_root_path
end

When /^I enter two different passwords$/ do
  step 'I fill in my profile details'
  fill_in 'intern_user_password', :with => 'differentpassword'
end

And /^I fill in my email address$/ do
  fill_in 'intern_user_email', :with => 'invite@test.com'
end

And /^I click the confirmation link in the email$/ do
  step 'I click the first link in the email'
end
