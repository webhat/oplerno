class InviteCredit < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :used, :user

  after_create :populate

  def populate
    self.used= false
    # TODO: get default value from settings
    self.amount= 50
  end
end
