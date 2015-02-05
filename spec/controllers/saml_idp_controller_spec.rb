require 'spec_helper'
require 'ruby-saml'

describe SamlIdpController do
  include SamlIdp::Controller

  def params
    @params ||= {}
  end

  it "should find the SAML ACS URL" do
    requested_saml_acs_url = "https://oplerno.com/saml/consume"
    params[:SAMLRequest] = make_saml_request(requested_saml_acs_url)
    validate_saml_request
    saml_acs_url.should == requested_saml_acs_url
  end

  context "SAML Responses" do
    before(:each) do
      params[:SAMLRequest] = make_saml_request
      validate_saml_request
    end

    it "should create a SAML Response" do
      saml_response = encode_SAMLResponse("foo@oplerno.com")
      response = OneLogin::RubySaml::Response.new(saml_response)
      response.name_id.should == "foo@oplerno.com"
      response.issuer.should == "http://oplerno.com"
      response.settings = saml_settings
      response.is_valid?.should be_true
    end

    [:sha1, :sha256, :sha384, :sha512].each do |algorithm_name|
      it "should create a SAML Response using the #{algorithm_name} algorithm" do
        self.algorithm = algorithm_name
        saml_response = encode_SAMLResponse("foo@oplerno.com")
        response = OneLogin::RubySaml::Response.new(saml_response)
        response.name_id.should == "foo@oplerno.com"
        response.issuer.should == "http://oplerno.com"
        response.settings = saml_settings
        response.is_valid?.should be_true
      end
    end
  end

  describe 'SAML SignIn' do
    context 'logged in as user' do
      login_user
      it 'should authenticate with existing user' do
        requested_saml_acs_url = "https://oplerno.instructure.com/"
        params[:SAMLRequest] = make_saml_request(requested_saml_acs_url)
        post :create, params

        expect(response).to be_success
        expect(response.status).to eq(200)
      end
      it 'should not authenticate with existing user from bad domain' do
        user = FactoryGirl.build(:user, password: 'testme')
        requested_saml_acs_url = "https://example.com/"
        params[:SAMLRequest] = make_saml_request(requested_saml_acs_url)
        post :create, params

        expect(response).to_not be_success
        expect(response.status).to eq(403)
      end
    end

    context 'not logged in as user' do
      it 'responds successfully with an HTTP 302 status code' do
        requested_saml_acs_url = "https://oplerno.test.instructure.com/"
        params[:SAMLRequest] = make_saml_request(requested_saml_acs_url)
        post :create, params, {}
        expect(response).to_not be_success
        expect(response.status).to eq(302)
      end
      it 'responds successfully redirects to new user session' do
        requested_saml_acs_url = "https://oplerno.test.instructure.com/"
        params[:SAMLRequest] = make_saml_request(requested_saml_acs_url)
        post :create, params, {}
        response.should redirect_to(new_user_session_url)
      end
    end
  end


  private

  def make_saml_request(requested_saml_acs_url = "https://foo.oplerno.com/saml/consume")
    auth_request = OneLogin::RubySaml::Authrequest.new
    auth_url = auth_request.create(saml_settings(requested_saml_acs_url))
    @request.host = 'oplerno.com'
    CGI.unescape(auth_url.split("=").last)
  end

  def saml_settings(saml_acs_url = "https://foo.oplerno.com/saml/consume")
    settings = OneLogin::RubySaml::Settings.new
    settings.assertion_consumer_service_url = saml_acs_url
    settings.issuer = "http://oplerno.com/issuer"
    settings.idp_sso_target_url = "http://idp.com/saml/idp"
    settings.idp_cert_fingerprint = SamlIdp::Default::FINGERPRINT
    settings.name_identifier_format = SamlIdp::Default::NAME_ID_FORMAT
    settings
  end

end
