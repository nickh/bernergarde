module AnyMatcher
  extend ActiveSupport::Concern

  module ClassMethods
    def matching_any(conditions)
      match_string = '%%%s%%'
      table = unscoped.table
      filter_conditions = conditions.reject{|column, val| !table.engine.column_names.include?(column) || val.blank?}
      Rails.logger.debug "conditions => #{conditions.inspect}"
      Rails.logger.debug "filter_conditions => #{filter_conditions.inspect}"
      column,val = filter_conditions.shift
      base = table[column].matches(match_string % val)
      where(filter_conditions.inject(base) do |where_clause, match|
        column,val = match
        where_clause.or(table[column].matches(match_string % val))
      end)
    end
  end
end
