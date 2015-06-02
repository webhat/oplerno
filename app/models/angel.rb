class Angel < ActiveRecord::Base
  belongs_to :mentor
  attr_accessible :adviser_to, :angelslug, :investor_in, :twitterslug, :mentor
end
