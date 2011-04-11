Factory.define :person do |person|
  person.name 'Dog Lover'
end

Factory.define :dog do |dog|
  dog.registered_name "Westminster's HiFiDolity"
  dog.call_name       'Fido'
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
