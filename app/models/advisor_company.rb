class AdvisorCompany < ActiveRecord::Base
  belongs_to :angels
  belongs_to :companies
  # attr_accessible :title, :body
end
