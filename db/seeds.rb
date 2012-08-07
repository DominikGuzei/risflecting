file = File.join Rails.root, "db", "seeds", "#{Rails.env}.rb"

load file if File.exist? file
