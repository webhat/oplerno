Authy.api_key = ENV['AUTHY_API_KEY'] || '591b17780a53fb9872ec1f17f49e4fff'
if ENV['AUTHY_API_KEY']
  Authy.api_uri = 'https://api.authy.com/'
else
  Authy.api_uri = 'http://sandbox-api.authy.com/'
end
