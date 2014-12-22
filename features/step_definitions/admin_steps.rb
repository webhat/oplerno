# encoding: utf-8
begin
  require 'rspec/expectations';
rescue LoadError;
  require 'spec/expectations';
end
require 'cucumber/formatter/unicode'


Given /^I am not authenticated as an AdminUser$/ do
  visit('/admin/logout') # ensure that at least
end

When /^I login as an AdminUser$/ do
  visit '/admin/login'
  fill_in 'admin_user[email]', :with => @user.email
  fill_in 'admin_user[password]', :with => @user.password
  #  FIXME: change these to the locale
  click_button 'Login' #I18n.t('devise.sessions.new.sign_in')
  @result = page.has_content? 'Logout' # I18n.t('devise.sessions.new.sign_out')
end

When /^I look at the (\w+) page$/ do |clazz|
  visit "/admin/#{clazz.underscore}"
  @result = page.has_content? 'Logout' # I18n.t('devise.sessions.new.sign_out')
end

When /^I look at the first (\w+)$/ do |clazz|
  FactoryGirl.create(clazz.underscore.to_sym)
  visit "/admin/#{clazz.underscore}s/#{clazz.constantize.first.id}"
  @result = page.has_content? 'Logout' # I18n.t('devise.sessions.new.sign_out')
end

When /^I look at the edit (\w+)$/ do |clazz|
  FactoryGirl.create(clazz.underscore.to_sym)
  visit "/admin/#{clazz.underscore}s/#{clazz.constantize.first.id}/edit"
  @result = page.has_content? 'Logout' # I18n.t('devise.sessions.new.sign_out')
end
