require 'spec_helper'

describe CertificatesController do
  before do
    Certificate.create! name: 'Test Certificate'
    (1..4).each do |id|
      Course.create! name: "Test Course #{id}"
    end
  end

  describe "GET :index" do
    context 'logged in' do
      login_user

      it "returns http success" do
        get :index
        expect(response).to be_success
      end
    end
    context 'not logged in' do
      it "returns http success" do
        get :index
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe "GET 'show'" do
    context 'logged in' do
      login_user

      it "returns http success" do
        get :show, {id: Certificate.first.id}
        expect(response).to be_success
      end
    end
    context 'not logged in' do
      it "returns http success" do
        get :show, {id: Certificate.first.id}
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe "POST 'create'" do
    context 'logged in' do
      login_user

      before do
        @course1 = FactoryGirl.create(:course)
      end

      context 'bad request' do
        it "returns http success" do
          post :create
          expect(response).to redirect_to certificates_url
        end
      end
      let(:valid_certificate) { { name:'History', courses: [
        @course1.id,
        @course1.id,
        @course1.id,
        @course1.id
      ] } }
      it "returns http success" do
        post :create, certificate: valid_certificate
        expect(response).to redirect_to certificates_url
      end
    end
    context 'not logged in' do
      context 'bad request' do
        it "returns http success" do
          post :create
          expect(response).to redirect_to new_user_session_url
        end
      end
      let(:valid_certificate) { { name:'History', courses: [1, 2, 3, 4] } }
      it "returns http success" do
        post :create, certificate: valid_certificate
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
