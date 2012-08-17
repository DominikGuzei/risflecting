module Intern::AppointmentsHelper
  def acceptance_button label, options = {}
    if options.has_key?(:remote) && options[:remote] == true
      link_to label, accept_intern_appointment_path(options[:appointment], :remote => true), :method => :post, :remote => true, :class => 'btn btn-success'
    else
      link_to label, accept_intern_appointment_path(options[:appointment]), :method => :post, :class => 'btn btn-success'
    end
  end

  def rejection_button label, options = {}
    if options.has_key?(:remote) && options[:remote] == true
      link_to label, reject_intern_appointment_path(options[:appointment], :remote => true), :method => :post, :remote => true, :class => 'btn btn-danger'
    else
      link_to label, reject_intern_appointment_path(options[:appointment]), :method => :post, :class => 'btn btn-danger'
    end
  end

  def format_time_period start_time, end_time
    if start_time.day == end_time.day
      (
        l(start_time, :format => '%d. %B %Y') +
        '<div class="times">' + l(start_time, :format => '%H.%M') + ' - ' + l(end_time, :format => '%H.%M') + ' Uhr' + '</div>'
      ).html_safe
    elsif start_time.month == end_time.month
      l(start_time, :format => '%d.') + ' - ' + l(end_time, :format => '%d. %B %Y')
    else
      l(start_time, :format => '%d. %b.') + ' - ' + l(end_time, :format => '%d. %b. %Y')
    end
  end
end
