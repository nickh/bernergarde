class SplitPersonName < ActiveRecord::Migration
  def self.up
    add_column :people, :first_name, :string
    add_column :people, :last_name,  :string
    Person.all.each do |person|
      first, last = person.name.split(' ',2)
      person.update_attributes(
        :first_name => first,
        :last_name  => last
      )
    end
    remove_column :people, :name
  end

  def self.down
    add_column :people, :name, :string
    Person.all.each do |person|
      person.update_attribute(:name, person.first_name + ' ' + person.last_name)
    end
    remove_column :people, :first_name
    remove_column :people, :last_name
  end
end
