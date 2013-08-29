require "spec_helper"

describe "devise/registrations/new" do

  before :each do
    user = mock_model("User").as_null_object.as_new_record
    assign(:user, user)
    render
  end

  it "contain header" do
    expect(rendered).to have_content("Регистрация пользователя")
  end

  it "with sign in link" do
    expect(rendered).to have_link("Войти", href: '/login')
  end

  it "with forgot password link" do
    expect(rendered).to have_link("Забыли свой пароль?", href: '/password/new')
  end

  context "render partials" do
    it "devise _form" do
      expect(view).to render_template(partial: '_form')
    end

    it "profile _form" do
      expect(view).to render_template(partial: 'profiles/_form')
    end

    it "devise shared/links" do
      expect(view).to render_template(partial: 'devise/shared/_links')
    end

    it "devise _links" do
      expect(view).to render_template(partial: '_links')
    end
  end

  context "render form" do
    context "user" do
      it "with name field" do
        expect(rendered).to have_selector("#user_name")
      end

      it "with email field" do
        expect(rendered).to have_selector("#user_email")
      end

      it "with password field" do
        expect(rendered).to have_selector("#user_password")
      end

      it "with password_confirmation field" do
        expect(rendered).to have_selector("#user_password_confirmation")
      end
    end

    context "profile" do
      it "with show email checkbox" do
        expect(rendered).to have_unchecked_field("user[profile_attributes][show_email]")
      end

      it "with country selector" do
        rendered.should have_select("user[profile_attributes][country]")
      end

      it "with birthday day selector" do
        rendered.should have_select("user[profile_attributes][birthday(3i)]")
      end

      it "with birthday month selector" do
        rendered.should have_select("user[profile_attributes][birthday(2i)]")
      end

      it "with birthday year selector" do
        rendered.should have_select("user[profile_attributes][birthday(1i)]")
      end

      xit "with about texarea" do
        rendered.should have_text("user[profile_attributes][about]")
      end

      xit "with signature texarea" do
        rendered.should have_text("user[profile_attributes][signature]")
      end

      it "with gender male" do
        expect(rendered).to have_field("user[profile_attributes][gender]", 
                                        type: "radio",
                                        with: "0"
                                        )
      end

      it "with gender female" do
        expect(rendered).to have_field("user[profile_attributes][gender]", 
                                        type: "radio",
                                        with: "1"
                                        )
      end

      it "with contacts phone" do
        expect(rendered).to have_field("user[profile_attributes][contacts_phone]", type: "text")
      end

      it "with contacts skype" do
        expect(rendered).to have_field("user[profile_attributes][contacts_skype]", type: "text")
      end

      it "with contacts other" do
        expect(rendered).to have_field("user[profile_attributes][contacts_other]", type: "text")
      end

      it "with contacts url" do
        expect(rendered).to have_field("user[profile_attributes][contacts_url]", type: "text")
      end

      it "with dispatch yes" do
        expect(rendered).to have_field("user[profile_attributes][dispatch]", 
                                        type: "radio",
                                        with: "true"
                                        )
      end

      it "with dispatch no" do
        expect(rendered).to have_field("user[profile_attributes][dispatch]", 
                                        type: "radio",
                                        with: "false"
                                        )
      end
    end

    it "with register button" do
      expect(rendered).to have_button("Присоединиться")
    end
  end

end