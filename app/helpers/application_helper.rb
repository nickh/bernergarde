module ApplicationHelper
  def bgf_page_class
    controller_name == 'pages' ? params[:id] : controller_name
  end

  def language_options
    [:en, :de, :nl].reject{|lang| I18n.locale == lang}
  end
end
