module ControllerMacros
  def login_as_user
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:valid_user, roles: FactoryGirl.create(:user_role))
      sign_in @user
    end
  end
end