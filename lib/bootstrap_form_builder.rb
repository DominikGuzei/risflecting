# This file goes in lib/
# Usage:
# <%= bootstrap_form_for @calendar_entry do |f| %>
#   <%= content_tag :legend, (locals[:title] || 'Edit Calendar Entry') %>
#   <%= f.text_field :name, :class => 'span3' %>
#   <%= f.text_area :description, :class => 'span3' %>
#   <%= f.datetime_picker :start_time, :class => 'span3' %>
#   <%= f.datetime_picker :end_time, :class => 'span3' %>
#   <%= f.check_box :all_day %>
#   <%= f.text_field :tag_string, :label => {:text => 'Tags'}, :class => 'span3' do %>
#     <p class="help-block">Use commas to separate tags.</p>
#   <% end %>
#   <div class="form-actions">
#     <%= f.submit 'Save', :class => 'btn btn-primary' %>
#     <%= link_to 'Cancel', calendar_entries_path, :class => 'btn' %>
#   </div>

module BootstrapFormBuilder
  module FormHelper
    [:form_for, :fields_for].each do |method|
      module_eval do
        define_method "bootstrap_#{method}" do |record, *args, &block|
          # add the TwitterBootstrap builder to the options
          options           = args.extract_options!
          options[:builder] = BootstrapFormBuilder::FormBuilder

          if method == :form_for
            options[:html] ||= {}
            options[:html][:class] ||= 'form-horizontal'
          end

          # call the original method with our overridden options
          send method, record, *(args << options), &block
        end
      end
    end
  end

  class FormBuilder < ActionView::Helpers::FormBuilder
    include FormHelper

    def get_error_text(object, field, options)
      if object.nil? || options[:hide_errors]
        ""
      else
        errors = object.errors[field.to_sym]
        if errors.empty? then "" else errors.first end
      end
    end

    def get_object_id(field, options)
      object = @template.instance_variable_get("@#{@object_name}")
      return options[:id] || object.class.name.underscore + '_' + field.to_s
    end

    def get_label(field, options)
      labelOptions = {:class => 'control-label'}.merge(options[:label] || {})
      text = labelOptions[:text] || nil
      labelTag = label(field, text, labelOptions)
    end

    def submit(value, options = {}, *args)
      super(value, {:class => "btn btn-inverse", :id => 'submit'}.merge(options){ |key, first, second| first + " " + second }, *args)
    end

    def check_box(field, options = {}, *args)
      object = @template.instance_variable_get("@#{@object_name}")

      labelTag = get_label(field, options)
      errorText = get_error_text(object, field, options)
      wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
      errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end

      ("<div class='#{wrapperClass}'>" +
          "<div class='controls'><label class='checkbox'>" +
            super(field, *args) +
            options[:label][:text] +
            errorSpan +
          "</label></div>" +
        "</div>"
      ).html_safe
    end

    def datetime_picker(field, options = {})
      # uses: https://github.com/eternicode/bootstrap-datepicker
      datetime_picker_javascript = "
        <script type='text/javascript'>
          $(function() { " +
            "$('##{field}_datepicker').datepicker({
              format: 'dd.mm.yyyy',
              weekStart: 1,
              startDate: '+0d',
              language: 'de',
              autoclose: true
            }).on('changeDate', function(event) {
              var dateString = $('##{field}_date').val().trim();
              if(dateString.length) {
                var dateParts = dateString.split('.');
                var date = new Date(dateParts[2], dateParts[1] - 1, dateParts[0], $('##{field}_hours').val(), $('##{field}_minutes').val());
              } else {
                var date = new Date();
                date.setHours($('##{field}_hours').val());
                date.setMinutes($('##{field}_minutes').val());
              }
              $('##{@object_name}_#{field}').val(date.toUTCString());
            });" +
            "$('##{field}_date, ##{field}_hours, ##{field}_minutes').on('change', function(event) {
              $('##{field}_datepicker').trigger('changeDate');
            });" +
          "});
        </script>"

      id = get_object_id(field, options)
      placeholder_text = options[:placeholder_text] || ''
      errorText = get_error_text(object, field, options)
      wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
      errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
      labelTag = get_label(field, options)

      date_time =
        if options[:start_time]
          options[:start_time]
        elsif object.nil?
          DateTime.now
        else
          object.send(field.to_sym)
        end

      date_string = unless date_time.nil? then date_time.strftime('%d.%m.%Y') else '' end
      hours_string = unless date_time.nil? then date_time.strftime('%H') else '12' end
      minutes_string = unless date_time.nil? then date_time.strftime('%M') else '00' end

      ("<div class='#{wrapperClass}'>" +
        labelTag +
        "<div class='controls'>" +
          @template.hidden_field(@object_name, field, :value => object.send(field.to_sym), :id => id) +
          "<div class='input-append date' id='#{field}_datepicker'>" +
            @template.text_field_tag("#{field}_date", '', {
              :placeholder => placeholder_text, :value => date_string, :class => options[:class]
            }.merge(options[:text_field] || {})) +
            "<span class='add-on'><i class='icon-th'></i></span>" +
          "</div>" +
          @template.select_tag("#{field}_hours", @template.options_for_select((6..23).to_a.map { |hour| sprintf '%02d', hour }, hours_string), :class => 'span1 hours-select') +
          @template.select_tag("#{field}_minutes", @template.options_for_select([0,15,30,45].map { |minute| sprintf '%02d', minute }, minutes_string), :class => 'span1 minutes-select') +
          errorSpan +
          datetime_picker_javascript +
        "</div>" +
      "</div>").html_safe
    end

    def file_field(field, options = {})
      id = get_object_id(field, options)
      placeholder_text = options[:placeholder_text] || ''

      file_input_javascript = "
        <script type='text/javascript'>
          $(function() {
            if($.browser.msie) {
              // use default file field in IE because otherwise IE emties file field before submit
              $('.file-input .hidden').remove()
            } else {
              $('.file-input .hidden').removeClass('hidden');
              $('##{@object_name}_#{field}')
                .css({ height: '1px', width: '1px', visibility: 'hidden', opacity: 0 })
                .change(function() {
                  var parts = ($(this).val()).split(/[\\\\/]/);
                  $('#file_name_field').val(parts[parts.length-1]);
                });
              $('#file_browse_button, #file_name_field').click(function() {
                $('##{@object_name}_#{field}').click();
              });
            }
          });
        </script>"

      errorText = get_error_text(object, field, options)
      wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
      errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
      labelTag = options[:label] ? get_label(field, options) : ''
      options[:button][:label] = 'Choose' if options[:button].nil? or options[:button][:label].nil?

      ("<div class='#{wrapperClass}'>" +
        labelTag +
        "<div class='controls'>" +
          "<div class='input-prepend file-input #{options[:class]}'>" +
            @template.button_tag(options[:button][:label], { :class => 'btn hidden', :id => 'file_browse_button', :type => 'button' }.merge(options[:button] || {})) +
            @template.text_field_tag("file_name_field", '', { :placeholder => placeholder_text, :disabled => true, :class => 'hidden' }) +
            super(field, {:id => id, :class => 'span4' }) +
          "</div>" +
          errorSpan +
          file_input_javascript +
        "</div>" +
      "</div>").html_safe
    end

    basic_helpers = %w{text_field text_area select email_field password_field number_field}

    multipart_helpers = %w{date_select datetime_select}

    basic_helpers.each do |name|
      # First alias old method
      class_eval("alias super_#{name.to_s} #{name}")

      define_method(name) do |field, *args, &help_block|
        options = args.last.is_a?(Hash) ? args.last : {}
        object = @template.instance_variable_get("@#{@object_name}")

        labelTag = options[:label] == false ? '' : get_label(field, options)

        errorText = get_error_text(object, field, options)

        wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
        errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
        ("<div class='#{wrapperClass}'>" +
            labelTag +
            "<div class='controls'>" +
              super(field, *args) +
              errorSpan +
              (help_block ? @template.capture(&help_block) : "") +
            "</div>" +
          "</div>"
        ).html_safe
      end
    end

    multipart_helpers.each do |name|
      define_method(name) do |field, *args, &help_block|
        options = args.last.is_a?(Hash) ? args.last : {}
        object = @template.instance_variable_get("@#{@object_name}")

        labelTag = get_label(field, options)

        options[:class] = 'inline ' + options[:class] if options[:class]

        errorText = get_error_text(object, field, options)

        wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
        errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
        ("<div class='#{wrapperClass}'>" +
            labelTag +
            "<div class='controls'>" +
                super(field, *args) +
                errorSpan +
                (help_block ? @template.capture(&help_block) : "") +
            "</div>" +
          "</div>"
        ).html_safe
      end
    end
  end
end
