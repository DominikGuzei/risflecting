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

Then /^I want to see the newly created project$/ do
  page.should have_content 'A new project'
  page.should have_content 'Some awesome stuff I did ...'
end

Given /^there is a project$/ do
  @project_data = { :title => 'Stupid title for a stupid project', :body => 'My really aweful experiences...' }
  @project = FactoryGirl.create :project, @project_data
end

Given /^there is a project from another user$/ do
  step 'there is a project'
end

Given /^I am on the project details page$/ do
  visit intern_project_path @project
end

Given /^there is a project of my own$/ do
  @project = FactoryGirl.create :project, :author => @current_user
end

Then /^I want to be on the project details page$/ do
  current_path.should == intern_project_path(@project)
end

When /^I chose a file to add to the project$/ do
  attach_file 'attachment_file', "#{Rails.root}/features/fixtures/test.png"
end

Given /^the project has (\d+) attached files?$/ do |amount_of_attachments|
  FactoryGirl.create_list :attachment, amount_of_attachments.to_i, :attachable => @project
end

Given /^there are (\d+) projects$/ do |amount_of_projects|
  FactoryGirl.create_list :project, amount_of_projects.to_i
end

Given /^I am on the projects page$/ do
  visit intern_projects_path
end

Then /^I want to see the title and author of the project$/ do
  page.should have_content @project.title
  page.should have_content @project.author.surname
end

Then /^I want to see a list of (\d+) projects$/ do |amount_of_projects|
  find('#projects-list').all('li').count.should == amount_of_projects.to_i
end

When /^I click on the title of the project$/ do
  click_on @project.title
end
