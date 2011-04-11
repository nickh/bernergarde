# This file contains custom RSpec matchers to allow for more consise/readable
# model specs.

# Verifies that the ActiveRecord model class has the specified attribute of the specified type
#
# Usage:
#
# describe MyModel do
#   it 'has attribute foo' do
#     MyModel.should have_attribute(:foo => :string)
#   end
# end
RSpec::Matchers.define :have_attribute do |expected|
  raise ArgumentError.new("expected :attr => :type hash") unless expected.is_a?(Hash) and expected.size == 1
  @expected_attr, @expected_type = expected.first

  match do |object|
    @klass = object.is_a?(Class) ? object : object.class
    @attr_present    = @klass.column_names.include?(@expected_attr)
    @attr_type_match = @attr_present ? @klass.columns_hash[@expected_attr].type == @expected_type : nil
    @attr_present && @attr_type_match
  end

  failure_message_for_should do |object|
    if @attr_present
      "Expected #{@klass}.#{@expected_attr} to be a #{@expected_type}, got #{@klass.columns_hash[@expected_attr].type}"
    else
      "Expected #{@klass} to have attribute #{@expected_attr}"
    end
  end
end

# Verifies that the ActiveRecord model instance has errors on the specified attribute
#
# Usage:
#
# context 'when the required foo is missing' do
#   it 'is not valid' do
#     Bar.new(:foo => nil).should have_errors_on :foo
#   end
# end
RSpec::Matchers.define :have_errors_on do |expected|
  match do |object|
    !object.valid? and object.errors.has_key?(expected) and !object.errors[expected].empty?
  end
end

# Verifies that the ActiveRecord class or instance has the specified :belongs_to association
#
# Usage:
#
# describe 'associations' do
#   it 'belongs to :baz' do
#     Foo.should belong_to(:baz)
#     # foo = Foo.new; foo.should belong_to(:baz) may also be used
#   end
#
#   # With a custom foreign key
#   it 'belongs to :bar with foreign key :my_bar' do
#     Foo.should belong_to(:bar, :foreign_key => :my_bar)
#   end
# end
RSpec::Matchers.define :belong_to do |*args|
  expected = args.first
  options = args.last.is_a?(Hash) ? args.pop : {}
  match do |object|
    (klass, instance) = begin
      if object.is_a?(Class)
        [object, object.new]
      else
        [object.class, object]
      end
    end
    verify_association(expected, object, :belongs_to, options)
  end
end

# Verifies that the ActiveRecord class or instance has the specified :has_one association
#
# Usage:
#
# describe Foo do
#   it 'has one :bar' do
#     Foo.should have_one(:bar)
#     # foo = Foo.new; foo.should have_one(:bar) may also be used
#   end
# end
RSpec::Matchers.define :have_one do |*args|
  expected = args.first
  options = args.last.is_a?(Hash) ? args.pop : {}
  match do |object|
    verify_association(expected, object, :has_one, options)
  end
end

# Verifies that the ActiveRecord class or instance has the specified :has_many association
#
# Usage:
#
# describe Foo do
#   it 'has many :baz' do
#     Foo.should have_many(:baz)
#     # foo = Foo.new; foo.should have_many(:baz) may also be used
#   end
# end
RSpec::Matchers.define :have_many do |*args|
  expected = args.first
  options = args.last.is_a?(Hash) ? args.pop : {}
  match do |object|
    verify_association(expected, object, :has_many, options)
  end
end

# Validates the specified association for one of the above custom matchers.  ActiveRecord
# has a list of configured associations in the class's 'reflections' Hash
def verify_association(expected, object, macro, options={})
  klass = object.is_a?(Class) ? object : object.class
  association = begin
    if expected.is_a?(Class)
      expected.to_s.downcase.to_sym
    elsif expected.is_a?(Symbol)
      expected
    else
      expected.to_sym
    end
  end
  klass.reflections.has_key?(association) and klass.reflections[association].macro == macro and (options.has_key?(:through) ? klass.reflections[association].options[:through] == options[:through] : true)
end
