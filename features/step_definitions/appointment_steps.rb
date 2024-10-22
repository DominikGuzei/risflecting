Given /^I visit the form to create a new appointment$/ do
  visit new_intern_appointment_path
end

When /^I fill in all fields of the appointment form$/ do
  fill_in 'appointment_title', :with => 'A new appointment'
  fill_in 'appointment_description', :with => 'Some descriptive words ...'
  fill_in 'appointment_location', :with => 'Sonnenhof, A-7022 Schattendorf'
  fill_in 'starttime_date', :with => 4.days.from_now.strftime('%d.%m.%Y')
  fill_in 'endtime_date', :with => 5.days.from_now.strftime('%d.%m.%Y')
end

Then /^I want to see the newly created appointment$/ do
  page.should have_content 'A new appointment'
  page.should have_content 'Some descriptive words ...'
  page.should have_content 'Sonnenhof, A-7022 Schattendorf'
end

Given /^there are (\d+) appointments ?(in the future)?$/ do |amount_of_appointments, expression|
  @amount_of_appointments = amount_of_appointments.to_i
  FactoryGirl.create_list(:appointment, @amount_of_appointments)
end

When /^I navigate to '([^"]+?)' through the main navigation$/ do |label|
  click_on label
end

Then /^I want to see all appointments listed$/ do
  find('#future-appointments').all('li').count.should == @amount_of_appointments
end

Given /^there is an appointment$/ do
  @appointment_data = { :title => "Test title", :description => "A quite short description ..." }
  @appointment = FactoryGirl.create(:appointment, @appointment_data)
end

Given /^I am on the appointments overview page$/ do
  visit intern_appointments_path
end

When /^I visit the appointments overview page$/ do
  visit intern_appointments_path
end

When /^I click on '([^"]*?)'$/ do |target_name|
  click_on target_name.to_s
end

When /^I click on the title of the appointment$/ do
  click_on @appointment_data[:title]
end

Then /^I want to see the details of the appointment$/ do
  page.should have_content @appointment_data[:title]
  page.should have_content @appointment_data[:description]
end

Then /^I do not want to see a link to create a new appointment$/ do
  page.should have_no_content('neuen Termin eintragen')
end

Then /^I want to get feedback that my acceptance succeeded$/ do
  page.should_not have_link('Zusagen')
  page.should have_content('zugesagt')
end

Given /^I have already accepted (\d+) appointments?$/ do |amount_of_appointments|
  amount_of_appointments = amount_of_appointments.to_i

  while amount_of_appointments > 0 do
    visit intern_appointments_path
    first('.btn-success').click

    amount_of_appointments -= 1
  end
end

Then /^I want to see (\d+) appointments? accepted$/ do |amount_of_appointments|
  sleep 0.5 # wait for ajax response - without this there is a deadlock detected PG:Error
  all('.label').count.should == amount_of_appointments.to_i
end

Then /^I want to get feedback that my rejection succeeded$/ do
  page.should_not have_link('Absagen')
  page.should have_content('abgesagt')
end

Given /^I have already rejected (\d+) appointments?$/ do |amount_of_appointments|
  amount_of_appointments = amount_of_appointments.to_i

  while amount_of_appointments > 0 do
    visit intern_appointments_path
    first('.btn-danger').click

    amount_of_appointments -= 1
  end
end

Then /^I want to see (\d+) appointments? rejected$/ do |amount_of_appointments|
  sleep 0.5 # wait for ajax response
  all('.label').count.should == amount_of_appointments.to_i
end

Given /^(\d+) users accepted the appointment$/ do |amount_of_accepting_users|
  amount_of_accepting_users = amount_of_accepting_users.to_i

  while amount_of_accepting_users > 0 do
    user = FactoryGirl.create :user
    user.accept_appointment @appointment.id

    amount_of_accepting_users -= 1
  end
end

Given /^I am on the appointment details page$/ do
  visit intern_appointment_path @appointment
end

When /^I visit the appointment details page$/ do
  visit intern_appointment_path @appointment
end

Then /^I want to see a list containing (\d+) users who accepted$/ do |amount_of_list_items|
  find('#acceptances').all('li').count.should == amount_of_list_items.to_i
end

Given /^(\d+) users rejected the appointment$/ do |amount_of_rejecting_users|
  amount_of_rejecting_users = amount_of_rejecting_users.to_i

  while amount_of_rejecting_users > 0 do
    user = FactoryGirl.create :user
    user.reject_appointment @appointment.id

    amount_of_rejecting_users -= 1
  end
end

Then /^I want to see a list containing (\d+) users who rejected$/ do |amount_of_list_items|
  find('#rejections').all('li').count.should == amount_of_list_items.to_i
end

When /^I fill in a URL in the description field$/ do
  fill_in 'appointment_description', :with => 'http://example.com'
end

Then /^I want the entered URL in the appointment description to be clickable$/ do
  within('#appointment-details') { find_link('http://example.com').should be_visible }
end

When /^I click on the trash bin icon$/ do
  find('.admin-tools a.trash').click
end

When /^I confirm the upcoming dialog$/ do
  # accept the confirmation if we use selenium - the poltergeist driver automatically confirms dialog popups
  page.driver.browser.switch_to.alert.accept unless Capybara.javascript_driver == :poltergeist
end

Then /^I want to get feedback that the appointment was deleted$/ do
  page.should have_selector('.flash-message.alert-success')
end

Then /^I want the appointment to be removed from the list$/ do
  page.should_not have_selector('ul#future-appointments')
end

Then /^I do not want to see a trash bin icon$/ do
  page.should_not have_selector '.admin-tools a.trash'
end

Given /^there is an appointment in the past$/ do
  @appointment = FactoryGirl.create :appointment, :starttime => 3.days.ago, :endtime => 2.days.ago
end

Then /^I want to see a list containing (\d+) future appointments$/ do |amount_of_list_items|
  find('#future-appointments').all('li').count.should == amount_of_list_items.to_i
end

Then /^I want to see a list containing (\d+) past appointment$/ do |amount_of_list_items|
  find('#past-appointments').all('li').count.should == amount_of_list_items.to_i
end

Then /^I want the past appointment not to be acceptable or rejectable$/ do
  within('#past-appointments') do
    should_not have_link 'Zusagen'
    should_not have_link 'Absagen'
  end
end

Then /^I do not want to see buttons to accept or reject$/ do
  should_not have_link 'Zusagen'
  should_not have_link 'Absagen'
end

Then /^I want to see the form to edit the appointment$/ do
  page.should have_selector '#appointment-edit-form'
end

Given /^I am on the appointment edit page$/ do
  visit edit_intern_appointment_path @appointment
end

When /^I change the title, description and location$/ do
  @changed_appointment = {
    :title => 'Changed Title',
    :description => 'Changed Description',
    :location => 'Changed Location'
  }

  fill_in 'appointment_title', :with => @changed_appointment[:title]
  fill_in 'appointment_description', :with => @changed_appointment[:description]
  fill_in 'appointment_location', :with => @changed_appointment[:location]
end

Then /^I want to see the changes on the appointment details page$/ do
  page.should have_content @changed_appointment[:title]
  page.should have_content @changed_appointment[:description]
  page.should have_content @changed_appointment[:location]
end

When /^I change none of the appointment information$/ do
  # do nothing
end

When /^I safe the appointment anyway$/ do
  step 'I save the changes'
end

Then /^I want to see the existing appointment information on the appointment details page$/ do
  page.should have_content @appointment.title
  page.should have_content @appointment.description
  page.should have_content @appointment.location
end

When /^I remove the title and location$/ do
  fill_in 'appointment_title', :with => ''
  fill_in 'appointment_location', :with => ''
end

Then /^I do not want to see a '([^"]+?)' link$/ do |word|
  page.should_not have_content word
end

Then /^I want to be on the appointments overview page$/ do
  current_path.should == intern_appointments_path
end

When /^I click on the pencil icon$/ do
  find('.admin-tools a.pencil').click
end

Then /^I do not want to see a pencil icon$/ do
  page.should_not have_selector '.admin-tools a.pencil'
end

Then /^I want to be on the appointment details page$/ do
  current_path.should == intern_appointment_path(@appointment)
end
