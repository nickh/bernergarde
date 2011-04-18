Factory.define :person do |person|
  person.first_name Faker::Name.first_name
  person.last_name  Faker::Name.last_name
end

Factory.define :dog do |dog|
  dog.registered_name Faker::Company.name + "'s " + Faker::Company.catch_phrase
  dog.call_name       Faker::Name.first_name
  dog.female          false
end

Factory.define :litter do |litter|
  litter.sire    {Factory(:dog, :female => false)}
  litter.dam     {Factory(:dog, :female => true)}
  litter.breeder
end

Factory.define :title do |title|
  title.code        'MVP'
  title.description 'Most Valuable Puppy'
end
