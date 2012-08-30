# encoding: utf-8

Given /^I am on the documents overview page$/ do
  visit intern_documents_path
end

Then /^I want to see the form to upload documents$/ do
  current_path.should == new_intern_document_path
end

Given /^I am on the page with the document upload form$/ do
  visit new_intern_document_path
end

When /^I choose a file to upload and fill in a title$/ do
  fill_in 'document_title', :with => 'A nice name for a document'
  attach_file 'document_asset', "#{Rails.root}/features/fixtures/test.png"
end

Then /^I do not want to see the button to add a new document$/ do
  page.should_not have_link 'neues Dokument hinzufügen'
end

Given /^there are (\d+) documents$/ do |amount_of_documents|
  FactoryGirl.create_list :document, amount_of_documents.to_i
end

Then /^I want to be on the documents overview page$/ do
  current_path.should == intern_documents_path
end

Then /^I want to see (\d+) documents listed$/ do |amount_of_list_items|
  find('#documents-list').all('tbody tr').count.should == amount_of_list_items.to_i
end

Given /^there is a document$/ do
  @document_data = { :title => 'My new document'}
  @document = FactoryGirl.create :document, @document_data
end

When /^I click on the document´s title$/ do
  within('#documents-list') { click_on @document_data[:title] }
end
