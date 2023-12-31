module ApplicationHelper
  include Pagy::Frontend
  # Returns the full title on a per-page basis.
  def full_title page_title
    base_title = I18n.t "layouts.header.title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
