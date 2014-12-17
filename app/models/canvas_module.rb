# Wrapper for #Canvas::API, handles the connection to Instructure's Canvas.
# @abstract
module CanvasModule

  def canvas
    @canvas
  end

  def connect_to_canvas_oauth(token = nil)
    token = ENV['CANVAS_TOKEN'] if token.nil?

    @canvas ||= Canvas::API.new(:host => "https://#{CANVAS_HOST}",
                                :token => token
                               )
  end

  def connect_to_canvas
    @canvas = Canvas::API.new(:host => "https://#{CANVAS_HOST}",
                              :client_id => ENV['CANVAS_USERNAME'],
                              :secret => ENV['CANVAS_PASSWORD']
                             )
    @canvas.oauth_url 'https://localhost/oauth_success'
  end
end
