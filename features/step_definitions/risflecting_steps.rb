Given /^I am on the Dashboard$/ do
  visit intern_dashboard_path
end

When /^I leave all fields empty$/ do
  # do not fill any of the form fields
end

Then /^I want to get feedback that the (\w+) was created successfully$/ do |word|
  page.should have_selector '.flash-message.alert-success'
end

When /^I save the (\w+)$/ do |expression|
  click_on 'submit'
end

Then /^I want to see (\d+) errors?$/ do |amount_of_errors|
  all('.control-group.error').count.should == amount_of_errors.to_i
end
