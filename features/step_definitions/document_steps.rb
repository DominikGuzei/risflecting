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
  page.should have_link 'neues Dokument hinzufügen'
end
