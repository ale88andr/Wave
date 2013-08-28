require "spec_helper"

describe "devise/registrations/new" do

  before :each do
    user = mock_model("User").as_null_object.as_new_record
    assign(:user, user)
    render
  end

  it "contain header" do
    expect(rendered).to have_content("Регистрация нового пользователя")
  end

  context "render partials" do
    it "devise _form" do
      expect(view).to render_template(partial: '_form')
    end

    it "profile _form" do
      expect(view).to render_template(partial: 'profile/_form')
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
        expect(rendered).to have_selector("form") do |form|
          form.should have_selector("input",
            :type => "checkbox",
            :name => "user[profile_attributes][show_email]"
          )
        end
      end

      it "with country selector" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("select",
            :name => "user[profile_attributes][country]"
          )
        end
      end

      it "with birthday day selector" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("select",
            :name => "user[profile_attributes][birthday(3i)]"
          )
        end
      end

      it "with birthday month selector" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("select",
            :name => "user[profile_attributes][birthday(2i)]"
          )
        end
      end

      it "with birthday year selector" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("select",
            :name => "user[profile_attributes][birthday(1i)]"
          )
        end
      end

      it "with about texarea" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("texarea",
            :name => "user[profile_attributes][about]"
          )
        end
      end

      it "with signature texarea" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("texarea",
            :name => "user[profile_attributes][signature]"
          )
        end
      end

      it "with gender male" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("input",
            :type => "radio",
            :name => "user[profile_attributes][gender]",
            :value => "0"
          )
        end
      end

      it "with gender female" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("input",
            :type => "radio",
            :name => "user[profile_attributes][gender]",
            :value => "1"
          )
        end
      end

      it "with profile show email checkbox" do
        rendered.should have_selector("form") do |form|
          form.should have_selector("input", 
            :type => "text", 
            :name => "user[profile_attributes][contacts_phone]"
          )
        end
      end
    end
  end

end