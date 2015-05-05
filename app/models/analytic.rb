class Analytic < ActiveRecord::Base
  attr_accessible :bytes, :referer, :remote, :request,
                  :status, :time, :user_agent,
                  :method, :path, :protocol
end
