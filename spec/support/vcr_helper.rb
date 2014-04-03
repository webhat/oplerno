require 'vcr'

VCR.configure do |c|
  c.ignore_request do |request|
    URI(request.uri).host == 'oplerno.test.instructure.com'
  end
	c.ignore_localhost = true
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
