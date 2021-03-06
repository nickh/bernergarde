module ApplicationHelper
  def bgf_page_class
    controller_name == 'pages' ? params[:id] : controller_name
  end

  def db_page_class
    controller_name
  end

  def bmdca_membership_status(person)
    "Member since 1f00"
  end

  def language_options
    [:en, :de, :nl].reject{|lang| I18n.locale == lang}
  end

  def sex_info(dog)
    if dog.female?
      t('db.dog.female') + (dog.neutered?? t('db.dog.spayed')   : '')
    else
      t('db.dog.male')   + (dog.neutered?? t('db.dog.neutered') : '')
    end
  end

  def state_options
    [
      [t('db.search.people.state_prompt'), ''],
      ["Alabama", "AL"],
      ["Alaska", "AK"],
      ["Alberta", "AB"],
      ["Arizona", "AZ"],
      ["Arkansas", "AR"],
      ["Armed Forces - America", "AA"],
      ["Armed Forces - Europe, Africa &amp; Middle East", "AE"],
      ["Armed Forces - Pacific", "AP"],
      ["Australian Capital Territory", "ACT"],
      ["British Columbia", "BC"],
      ["California", "CA"],
      ["Colorado", "CO"],
      ["Connecticut", "CT"],
      ["Delaware", "DE"],
      ["District of Columbia", "DC"],
      ["Florida", "FL"],
      ["Georgia", "GA"],
      ["Hawaii", "HI"],
      ["Idaho", "ID"],
      ["Illinois", "IL"],
      ["Indiana", "IN"],
      ["Iowa", "IA"],
      ["Kansas", "KS"],
      ["Kentucky", "KY"],
      ["Louisiana", "LA"],
      ["Maine", "ME"],
      ["Manitoba", "MB"],
      ["Maryland", "MD"],
      ["Massachusetts", "MA"],
      ["Michigan", "MI"],
      ["Minnesota", "MN"],
      ["Mississippi", "MS"],
      ["Missouri", "MO"],
      ["Montana", "MT"],
      ["N.W. Territory", "NWT"],
      ["Nebraska", "NE"],
      ["Nevada", "NV"],
      ["New Brunswick", "NB"],
      ["New Hampshire", "NH"],
      ["New Jersey", "NJ"],
      ["New Mexico", "NM"],
      ["New South Wales (Australia)", "NSW"],
      ["New York", "NY"],
      ["Newfoundland &amp; Labrador", "NL"],
      ["North Carolina", "NC"],
      ["North Dakota", "ND"],
      ["Northern Territory (Australia)", "NT"],
      ["Northwest Territory (Canada)", "NW"],
      ["Nova Scotia", "NS"],
      ["Nunavut Territory (Canada)", "NU"],
      ["Ohio", "OH"],
      ["Oklahoma", "OK"],
      ["Ontario", "ON"],
      ["Oregon", "OR"],
      ["Pennsylvania", "PA"],
      ["Prince Edward Island", "PE"],
      ["Quebec", "QC"],
      ["Queensland (Australia)", "QLD"],
      ["Rhode Island", "RI"],
      ["Saskatchewan", "SK"],
      ["South Australia", "SA"],
      ["South Carolina", "SC"],
      ["South Dakota", "SD"],
      ["Tasmania (Australia)", "TAS"],
      ["Tennessee", "TN"],
      ["Texas", "TX"],
      ["Utah", "UT"],
      ["Vermont", "VT"],
      ["Victoria (Australia)", "VIC"],
      ["Virginia", "VA"],
      ["Washington", "WA"],
      ["West Virginia", "WV"],
      ["Western Australia", "WA-A"],
      ["Wisconsin", "WI"],
      ["Wyoming", "WY"],
      ["Yukon", "YT"],
    ]
  end

  def country_options
    [
      [t('db.search.people.country_prompt'), ''],
      ["Andorra", "AD"],
      ["Argentina", "AR"],
      ["Australia", "AU"],
      ["Austria", "AT"],
      ["Bahamas", "BS"],
      ["Belgium", "BE"],
      ["Bermuda", "BM"],
      ["Brazil", "BZ"],
      ["Canada", "CA"],
      ["Chile", "CL"],
      ["China", "CN"],
      ["Colombia", "CO"],
      ["Croatia", "CR"],
      ["Czech Republic", "CZ"],
      ["Denmark", "DK"],
      ["Ecuador", "EC"],
      ["Estonia", "EE"],
      ["Finland", "FI"],
      ["France", "FR"],
      ["Germany", "DE"],
      ["Great Britain", "UK"],
      ["Greece", "GR"],
      ["Hungary", "HU"],
      ["Iceland", "IS"],
      ["India", "IND"],
      ["Ireland", "IR"],
      ["Israel", "IL"],
      ["Italy", "IT"],
      ["Japan", "JP"],
      ["Latvia", "LV"],
      ["Lithuania", "LT"],
      ["Mexico", "MX"],
      ["New Zealand", "NZ"],
      ["Norway", "NO"],
      ["Poland", "POL"],
      ["Portugal", "PT"],
      ["Romania", "RO"],
      ["Russia", "RUS"],
      ["Scotland", "SC"],
      ["Serbia", "RS"],
      ["Slovakia", "SVK"],
      ["Slovenia", "SI"],
      ["South Africa", "SA"],
      ["Spain", "SP"],
      ["Sweden", "SE"],
      ["Switzerland", "CH"],
      ["The Netherlands", "NL"],
      ["Turkey", "TR"],
      ["Ukraine", "UKR"],
      ["United States of America", "US"],
      ["Uruguay", "UY"],
    ]
  end
end
