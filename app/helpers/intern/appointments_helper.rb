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
end
