# General seeds which are the same for all environments
Role.find_or_create_by_name 'Admin'
Role.find_or_create_by_name 'Member'

# Specific seeds
file = File.join Rails.root, "db", "seeds", "#{Rails.env}.rb"

load file if File.exist? file
