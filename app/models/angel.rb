class Angel < ActiveRecord::Base
  belongs_to :mentor
  has_and_belongs_to_many :advisors, :join_table => 'advisors_companies', class_name: 'Company'
  has_and_belongs_to_many :investors, :join_table => 'companies_investors', class_name: 'Company'
  attr_accessible :adviser_to, :angelslug, :investor_in, :twitterslug, :mentor

  def worked_with
    self.advisors + self.investors
  end
end
