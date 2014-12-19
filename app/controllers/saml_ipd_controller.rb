# This class only accepts SAML requests from Instructure if you are already authenticated
class SamlIdpController < SamlIdp::IdpController
  before_filter :authenticate_user!
  before_filter :find_account

  def idp_authenticate(email, password)
    user = User.find_by_email(params[:email])
    user && user.valid_password?(params[:password]) ? user : nil
  end

  def idp_make_saml_response(user)
    encode_SAMLResponse(user.email)
  end

  private

  # find_account ensures that if you are coming from *HOST.instructure.com* you can authenticate with SAML
  def find_account
    @subdomain = saml_acs_url[/https?:\/\/(.+?)\.instructure.com/, 1]
    if @subdomain == 'oplerno'
      @saml_response = idp_make_saml_response(current_user)
      render :template => "saml_idp/idp/saml_post", :layout => false
      return
    end
    render :create, status: :forbidden
  end
end
