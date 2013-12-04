require 'spec_helper'

describe StudentsController do
  include Devise::TestHelpers

  let(:valid_attributes) { {email: 'example_student@oplerno.com', password: '1234567890', password_confirmation: '1234567890'} }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index  , {}, valid_session
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index       , {}, valid_session
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      student = Student.create! valid_attributes
      get :show, {:id => student.to_param}, valid_session
      assigns(:student).should eq(student)
    end
  end
end
