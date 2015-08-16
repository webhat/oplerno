# This controller expects you to use the URLs /saml/init and /saml/consume in your OneLogin application.
class SamlController < ApplicationController
  def init
    request = Onelogin::Saml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    response          = Onelogin::Saml::Response.new(params[:SAMLResponse])
    response.settings = saml_settings

    if response.is_valid? && user = current_account.users.find_by_email(response.name_id)
      authorize_success(user)
    else
      authorize_failure(user)
    end
  end

  private

  def saml_settings
    settings = Onelogin::Saml::Settings.new

    settings.assertion_consumer_service_url = "http://#{request.host}/saml/consume"
    settings.issuer                         = request.host
    settings.idp_sso_target_url             = "https://localhost:3000/saml/auth/#{OneLoginAppId}"
    settings.idp_cert_fingerprint = "BC:E7:93:9F:0B:D4:C2:49:53:64:88:70:7E:EA:3F:48:6E:92:B7:34"
    settings.name_identifier_format = SamlIdp::Default::NAME_ID_FORMAT
    settings.certificate = SamlIdp.config.x509_certificate
    settings.private_key = SamlIdp.config.secret_key

    settings
  end
end
