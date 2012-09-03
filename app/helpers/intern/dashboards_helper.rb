module Intern::DashboardsHelper
  def truncate_title title, time_text
    available_length = 65 - time_text.size
    truncate title, :length => available_length, :separator => ' ', :omission => ' ...'
  end
end
