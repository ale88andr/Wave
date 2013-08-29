require 'spec_helper'

describe "profiles/show" do
  
  let!(:user) { FactoryGirl.create(:valid_user) }

  before :each do
    user.build_profile
    assign(:user, user)
    sign_in user
    render
  end

  context "render template" do
    it "with header" do
      expect(rendered).to have_selector "h3", "Просмотр профиля пользователя \"#{user.name}\""
    end

    context "when user is profile owner" do
      it "with edit button" do
        expect(rendered).to have_link "Редактировать свой профиль"
      end

      it "with delete account button" do
        expect(rendered).to have_button "Удалить мой аккаунт"
      end
    end

    context "when user not profile owner" do
      before :each do
        controller.stub!(:current_user).and_return(FactoryGirl.attributes_for(:valid_user))
      end

      xit "without edit button" do
        expect(rendered).not_to have_link "Редактировать свой профиль", href: '/edit'
      end

      xit "without delete account button" do
        expect(rendered).not_to have_button "Удалить мой аккаунт"
      end
    end
  end
end