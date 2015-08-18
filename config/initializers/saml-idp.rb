SamlIdp.config.x509_certificate = File.read(Rails.root.join('config', 'saml', 'saml.pub')).gsub(/\w*-+(BEGIN|END) CERTIFICATE-+\w*/, "").strip
SamlIdp.config.secret_key = File.open(Rails.root.join('config', 'saml', 'saml.pem')) { |file| file.read }
