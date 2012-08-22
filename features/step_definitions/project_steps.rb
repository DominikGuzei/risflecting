Given /^I am on the projects overview page$/ do
  visit intern_projects_path
end

Then /^I want to see the form to create a new project$/ do
  current_path.should == new_intern_project_path
end

Given /^I visit the form to create a new project$/ do
  visit new_intern_project_path
end

When /^I fill in all fields of the project form$/ do
  fill_in 'project_title', :with => 'A new project'
  fill_in 'project_body', :with => 'Some awesome stuff I did ...'
end

Then /^I want some feedback that the project was created successfully$/ do
  page.should have_selector('.flash-message.alert-success')
end

Then /^I want to see the newly created project$/ do
  page.should have_content 'A new project'
  page.should have_content 'Some awesome stuff I did ...'
end
