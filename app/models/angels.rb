class Angels < ActiveRecord::Base
  belongs_to :user_id
  attr_accessible :adviser_to, :angelslug, :investor_in, :twitterslug
end
