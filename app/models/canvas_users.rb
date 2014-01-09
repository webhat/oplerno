class CanvasUsers < ActiveRecord::Base
  belongs_to :user
  attr_accessible :avatal_url, :canvas_id, :locale, :username
end
