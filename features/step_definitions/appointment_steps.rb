Given /^I visit the form to create a new appointment$/ do
  visit '/intern/appointments/new'
end

When /^I fill in all fields$/ do
  fill_in 'appointment_title', :with => 'A new appointment'
  fill_in 'appointment_description', :with => 'Some descriptive words ...'
  fill_in 'appointment_location', :with => 'Sonnenhof, A-7022 Schattendorf'
  fill_in 'starttime_date', :with => 4.days.from_now.strftime('%d.%m.%Y')
  fill_in 'endtime_date', :with => 5.days.from_now.strftime('%d.%m.%Y')
end

When /^I save the appointment$/ do
  click_on 'submit'
end

Then /^I want some feedback that the appointment was created successfully$/ do
  page.should have_selector '.flash-message.alert-success'
end

Then /^I want to see the newly created appointment$/ do
  page.should have_content 'A new appointment'
  page.should have_content 'Some descriptive words ...'
end

When /^I leave all fields empty$/ do
  # do not fill any of the form fields
end

Then /^I want to see (\d+) errors$/ do |amount_of_errors|
  all('.control-group.error').count.should == amount_of_errors.to_i
end

Given /^I am on the Dashboard$/ do
  visit '/intern/dashboard'
end

Given /^there are (\d+) appointments$/ do |amount_of_appointments|
  @amount_of_appointments = amount_of_appointments.to_i
  FactoryGirl.create_list(:appointment, @amount_of_appointments)
end

When /^I navigate to 'Termine' through the main navigation$/ do
  click_on 'Termine'
end

Then /^I want to see a list of all appointments$/ do
  find('#appointment-list').all('li').count.should == @amount_of_appointments
end
