namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    @breeders = make_breeders
    make_dogs
    make_owners
  end
end

# Create people with a kennel name
def make_breeders
  (1..10).collect{|i| Person.create!(
      :name         => Faker::Name.name,
      :country      => 'US',
      :address      => Faker::Address.street_address + ', ' + Faker::Address.city + ' ' + Faker::Address.us_state_abbr + ' ' + Faker::Address.zip,
      :email        => Faker::Internet.email,
      :phone        => Faker::PhoneNumber.phone_number,
      :kennel_name  => Faker::Company.name,
      :bmdca_status => "Member since #{Time.now.year - rand(30)} (paid thru Apr 1, #{Time.now.year + 1})",
      :data_source  => 'BG People Submission'
  )}
end

# Create a sire/dam/litter for each breeder
def make_dogs
  @breeders.each do |breeder|
    sire = Dog.create!(
      :registered_name => Faker::Company.name + "'s " + Faker::Company.catch_phrase,
      :call_name       => Faker::Name.first_name,
      :female          => false,
      :owner           => breeder
    )
    dam = Dog.create!(
      :registered_name => Faker::Company.name + "'s " + Faker::Company.catch_phrase,
      :call_name       => Faker::Name.first_name,
      :female          => true,
      :owner           => breeder
    )
    litter = Litter.create( # breeder, sire, dam, whelp_date
      :breeder    => breeder,
      :sire       => sire,
      :dam        => dam,
      :whelp_date => rand(1000).days.ago
    )
    1.upto(1+rand(10)) do |i|
      litter.dogs << Dog.create(
        :registered_name => breeder.kennel_name + 's ' + Faker::Company.catch_phrase,
        :call_name       => Faker::Name.first_name,
        :female          => rand(2) == 1
      )
    end
  end
end

# Create owners for dogs that don't have them, allow some existing owners to have more than one dog
def make_owners
  owners = []
  Dog.where(:owner_id => nil).each do |dog|
    n = rand(owners.size * 4)
    dog.update_attribute(:owner, owners[n] || Person.create(
      :name         => Faker::Name.name,
      :country      => Faker::Address.country,
      :address      => Faker::Address.street_address + ', ' + Faker::Address.city + ' ' + Faker::Address.us_state_abbr + ' ' + Faker::Address.zip,
      :email        => Faker::Internet.email,
      :phone        => Faker::PhoneNumber.phone_number,
      :bmdca_status => "Member since #{Time.now.year - rand(30)} (paid thru Apr 1, #{Time.now.year + 1})",
      :data_source  => 'BG People Submission'
    ))
  end
end
