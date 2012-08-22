module ApplicationHelper

  def page_title(title)
    content_for :page_title do title end
  end

  def page_stylesheet(path, options)
    content_for :stylesheet_includes do
      stylesheet_link_tag path, options
    end
  end

  def page_javascript(path)
    content_for :javascript_includes do
      javascript_include_tag path
    end
  end
end
