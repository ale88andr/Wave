require 'spec_helper'

describe "devise/sessions/new" do
  before :each do
    render
  end

  context "render" do
    it "with greeting" do
      expect(rendered).to have_content("Вход в аккаунт")
    end

    it "with sign in form" do
      expect(rendered).to have_selector("form#new_user")
    end

    it "with register link" do
      expect(rendered).to have_link("Регистрация", href: '/register')
    end

    it "with forgot password link" do
      expect(rendered).to have_link("Забыли свой пароль?", href: '/password/new')
    end

    context "sign in form" do
      it "with name field" do
        expect(rendered).to have_field("user[name]", type: "text")
      end

      it "with password field" do
        expect(rendered).to have_field("user[password]", type: "password")
      end

      it "with remember me chekbox" do
        expect(rendered).to have_unchecked_field("user[remember_me]")
      end

      it "with sign in button" do
        expect(rendered).to have_button("Войти")
      end
    end
  end
end