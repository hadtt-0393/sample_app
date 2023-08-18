class ApplicationController < ActionController::Base
  before_action :set_locale

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    default = I18n.default_locale
    I18n.locale = I18n.available_locales.include?(locale) ? locale : default
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
