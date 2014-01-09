require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  let(:valid_attributes) { {email: 'example_user@oplerno.com', password: '1234567890'} }

  let(:valid_session) { {} }

  describe "there is no route to users"
end

