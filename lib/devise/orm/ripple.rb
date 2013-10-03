require 'orm_adapter/adapters/ripple'

Ripple::Document::ClassMethods.send :include, Devise::Models

