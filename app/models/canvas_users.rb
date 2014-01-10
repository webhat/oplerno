class CanvasUsers < ActiveRecord::Base
  belongs_to :user
  attr_accessible :avatal_url, :canvas_id, :locale, :username

  @@canvas = nil

  def self.update(canvas_user)
    self.connect_to_canvas if @@canvas.nil?
  end

  def self.update_all
    CanvasUsers.all.each do |canvas_user|
      update canvas_user
    end
  end

  def self.connect_to_canvas
    @@canvas ||= Canvas::API.new(:host => 'https://oplerno.test.instructure.com',
                             :client_id => ENV["CANVAS_USERNAME"],
                             :secret => ENV["CANVAS_PASSWORD"]
    )
    p @@canvas
  end
end
