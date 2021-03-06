class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def default_url_options(options={})
    options.merge(:locale => I18n.locale)
  end

  private
    def set_locale
      I18n.locale = params[:locale] || session[:locale]
    end
end
