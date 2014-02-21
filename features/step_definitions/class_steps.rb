# encoding: utf-8
begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'

Before do
end

After do
  @object = nil
end

Given /I have a (.*) called '(.*)' with (\w+) $(\d+)/ do |clazz, name, attribute, value|
  object = Object.const_get(clazz).new
  object.send("name=", name)
  object.send("#{attribute}=", value)
  object.save
end

Given /My (\w+) contains a (\w+) with (\w+): '(.*)'/ do |clazz, with_clazz, attribute, value|
  @object = Object.const_get(clazz).new
  @user.send("#{clazz.downcase}=", @object)
  object = @object.send("#{with_clazz.downcase}s").build() #send('push', Object.const_get(with_clazz).find_by_name(name))
  object.send("#{attribute}=", value)
  object.save
  @object.save
end

#     "The Course with name: 'Test Course' has price: $1000"
Given /The (\w+) with (\w+): '(.*)' has (\w+): \$(\d+)/ do |clazz, search_attribute, search_value, attribute, value|
  object = Object.const_get(clazz).send("find_by_#{search_attribute}", search_value)
  object.send("#{attribute}=", value)
  object.save
end

Given /The (\w+) with (\w+): '(.*)' has (\w+): (\d+)/ do |clazz, search_attribute, search_value, attribute, value|
  object = Object.const_get(clazz).send("find_by_#{search_attribute}", search_value)
  object.send("#{attribute}=", value)
  object.save
end

#		* I add the Subject 'Test'
Given /I add the (\w+): '(.*)'/ do |clazz, value|
	object = Object.const_get(clazz).new
	object.send("#{clazz.downcase}=", value)
	@object.send("#{clazz.downcase}s").send('push', object)
  object.save
end

Given /I have a (\w+)/ do |clazz|
  @object = Object.const_get(clazz).new
end

Given /I entered my (.*): '(.*)'/ do |attribute, value|
  attribute.gsub!(/ /, '_')
  @object.send("#{attribute}=", value)
end

Given /I don't enter a (\w+)/ do |op|
  # noop
end

Given /I am a User/ do
  @user = FactoryGirl.create(:user)
end

When /I press (\w+)/ do |op|
  @result = @object.send op
end

When /I placed my Order/ do
  @object.courses_to_student
end

Then /I get an error/ do
  @result.should_not eq true
end

Then /It succeeds/ do
  @result.should eq true
end

Then /I am enrolled in '(.*)'/ do |course_name|
  @user.courses[0].name.should eq course_name
end
