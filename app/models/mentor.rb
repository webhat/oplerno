class Mentor < User
  has_and_belongs_to_many :teams

  def tags
    ['SSG', 'EdTech', 'Investor', 'SaaS', 'Local', 'Retail', 'FinTech']
  end
end
