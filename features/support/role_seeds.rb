Before do
  # The cucumber acceptance tests need roles in order to work
  # Therefore we will create them for every scenario
  Role.find_or_create_by_name 'Admin'
  Role.find_or_create_by_name 'Member'
end
