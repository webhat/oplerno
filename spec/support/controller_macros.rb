module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin_users]
      sign_in FactoryGirl.create(:admin_user) # Using factory girl as an example
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @_user = FactoryGirl.build(:user)
      @_user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      @_user.skip_confirmation_notification!
      @_user.save
      sign_in @_user

      def current_user
        @_user
      end
    end
  end
end
