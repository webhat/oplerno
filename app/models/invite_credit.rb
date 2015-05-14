class InviteCredit < ActiveRecord::Base
  belongs_to :user
  belongs_to :by, class_name: 'User'
  attr_accessible :amount, :used, :user, :user_id, :by, :by_id

  after_initialize :populate

  def populate
    self.used ||= false
    # TODO: get default value from settings
    self.amount ||= 50
  end

  def by_id= id
    self.by = User.find(id)
  end

  def user_id= id
    self.user = User.find(id)
  end
end
