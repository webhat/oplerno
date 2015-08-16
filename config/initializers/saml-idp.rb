SamlIdp.config.x509_certificate = Base64.encode64 File.open(Rails.root.join('config', 'saml', 'saml.pub')) { |file| file.read }
SamlIdp.config.secret_key = File.open(Rails.root.join('config', 'saml', 'saml.pem')) { |file| file.read }
