class InviteCredit < ActiveRecord::Base
  belongs_to :user
  belongs_to :by, class_name: 'User'
  attr_accessible :amount, :used, :user, :by

  after_initialize :populate

  def populate
    self.used ||= false
    # TODO: get default value from settings
    self.amount ||= 50
  end
end
