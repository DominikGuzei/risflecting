# encoding: utf-8

Given /^I am signed in as a user$/ do
  user = FactoryGirl.create :user

  visit new_intern_user_session_path
  fill_in 'intern_user_email', :with => user.email
  fill_in 'intern_user_password', :with => user.password
  click_on 'submit'

  @current_user = user
end

Given /^I am signed in as an admin$/ do
  user = FactoryGirl.create :admin

  visit new_intern_user_session_path
  fill_in 'intern_user_email', :with => user.email
  fill_in 'intern_user_password', :with => user.password
  click_on 'submit'
end

Given /^I am signed in as a coordinator$/ do
  user = FactoryGirl.create :coordinator

  visit new_intern_user_session_path
  fill_in 'intern_user_email', :with => user.email
  fill_in 'intern_user_password', :with => user.password
  click_on 'submit'
end

Given /^I am signed out$/ do
  visit destroy_intern_user_session_path
end

Given /^I visit the form to invite a new user$/ do
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

Then /^I want to see the form to invite a new user again$/ do
  current_path.should == new_intern_account_path
end

Given /^I fill an already invited email address$/ do
  fill_in 'user_email', :with => User.first.email
end

Then /^the user should have received an email with instructions$/ do
  step '"invite@test.com" should receive an email'
end

Given /^I have an invitation email$/ do
  user = User.new :email => 'invite@test.com'
  user.role = Role.find_by_name 'Member'
  user.save :validate => false
end

When /^I open my invitation email$/ do
  open_email 'invite@test.com'
end

When /^I fill in my account details$/ do
  fill_in 'intern_user_forename', :with => 'Walter'
  fill_in 'intern_user_surname', :with => 'White'
  fill_in 'intern_user_phone', :with => '+436642312342'
  fill_in 'intern_user_password', :with => 'password'
  fill_in 'intern_user_password_confirmation', :with => 'password'
end

When /^I confirm my account$/ do
  click_on 'submit'
end

Then /^I want to be able to access the internal website$/ do
  current_path.should == intern_root_path
end

Then /^I want to be redirected to the internal website$/ do
  current_path.should == intern_root_path
end

When /^I enter two different passwords$/ do
  step 'I fill in my account details'
  fill_in 'intern_user_password', :with => 'differentpassword'
end

And /^I fill in my email address$/ do
  fill_in 'intern_user_email', :with => 'invite@test.com'
end

And /^I click the confirmation link in the email$/ do
  step 'I click the first link in the email'
end

Then /^I want to see feedback that I have to enter an email$/ do
  page.should have_selector '.flash-message.alert-error'
end

Then /^I want to see feedback that the user is already invited$/ do
  page.should have_selector '.flash-message.alert-error'
end

Given /^my account is confirmed$/ do
  step 'I fill in my account details'
  step 'I confirm my account'
end

When /^I sign out$/ do
  step 'I am signed out'
end

Then /^I do not want to see a link to invite a new user$/ do
  page.should have_no_content('Benutzer erstellen')
end

When /^I click on my name in the main navigation$/ do
  within('#main-navigation') { click_on @current_user.full_name }
end

When /^I navigate to '([^"]+?)'$/ do |word|
  within('#account-dropdown') { click_on word }
end

Then /^I want to see my account details$/ do
  page.should have_content @current_user.full_name
  page.should have_content @current_user.email
  page.should have_content @current_user.phone
end

Given /^I am on my profile page$/ do
  visit intern_profile_path
end

Then /^I want to see the form to edit my profile information$/ do
  page.should have_selector '#account-edit-form'
end

Given /^I am on the page with the profile edit form$/ do
  visit edit_intern_profile_path
end

When /^I choose a new avatar image$/ do
  attach_file 'user_avatar', "#{Rails.root}/features/fixtures/test.png"
end

Then /^I want to see the newly uploaded avatar on my profile page$/ do
  page.should have_image @current_user.avatar.filename
end

When /^I click on the name of the (\w+)´s author$/ do |word|
  @author = instance_variable_get("@#{word}").send :author
  first(:link, @author.full_name).click
end

Then /^I want to see the author´s profile$/ do
  current_path.should == intern_account_path(@author)
end

Given /^the question has a comment$/ do
  @comment = FactoryGirl.create :comment, :question => @question, :author => @author
end

Given /^(\d+) user already accepted that appointment$/ do |arg1|
  appointment_response = FactoryGirl.create :appointment_response, :appointment => @appointment, :accepted => true
  @accepted_user = appointment_response.user
end

When /^I click on the user´s name$/ do
  click_link @accepted_user.formal_name
end

Then /^I want to see the user´s profile$/ do
  current_path.should == intern_account_path(@accepted_user)
end

When /^I change my name, email and phone$/ do
  fill_in 'user_surname', :with => 'Potter'
  fill_in 'user_forename', :with => 'Lili'
  fill_in 'user_email', :with => 'lili@potter.at'
  fill_in 'user_phone', :with => '+431111111111'
end

Then /^I want to see the changes on my profile page$/ do
  page.should have_content 'Potter'
  page.should have_content 'Lili'
  page.should have_content 'lili@potter.at'
  page.should have_content '+431111111111'
end

When /^I remove my name, email and phone$/ do
  fill_in 'user_surname', :with => ''
  fill_in 'user_forename', :with => ''
  fill_in 'user_email', :with => ''
  fill_in 'user_phone', :with => ''
end

When /^I change none of my informations$/ do
  # do nothing
  @current_user_data = {
    :surname => @current_user.surname,
    :forename => @current_user.forename,
    :email => @current_user.email,
    :phone => @current_user.phone
  }
end

When /^I save the informations anyway$/ do
  step 'I save the changes'
end

Then /^I want to see the existing informations on my profile page$/ do
  page.should have_content @current_user_data[:surname]
  page.should have_content @current_user_data[:forename]
  page.should have_content @current_user_data[:email]
  page.should have_content @current_user_data[:phone]
end

When /^I add a description with some informations about me$/ do
  fill_in 'user_description', :with => 'Description with some informations about me'
end

Then /^I want to see the description on my profile page$/ do
  page.should have_content 'Description with some informations about me'
end

Then /^I want to see feedback that the changes were successfully saved$/ do
  page.should have_selector '.flash-message.alert-success'
end

When /^I select the '([^"]+?)' group for the user$/ do |group|
  select group, :from => 'Gruppe'
end

Then /^the user should belong to the '([^"]+?)' group$/ do |group|
  case group
  when 'Pool'
    role = :member
  when 'Steuergruppe'
    role = :coordinator
  when 'Administratoren'
    role = :admin
  end

  User.last.has_role?(role).should be true
end
