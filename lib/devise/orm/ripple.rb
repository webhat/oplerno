require 'orm_adapter/adapters/ripple'
require 'devise/action_dispatch'

Ripple::Document::ClassMethods.send :include, Devise::Models

