require 'spec_helper'

describe Backend::ManufacturersController do

  describe "GET #index" do
    let!(:manufacturer) { FactoryGirl.create(:manufacturer) }

    before { get :index }

    it "populates an array of manufacturers" do
      expect(assigns[:manufacturers]).to eq [manufacturer]
    end

    it "renders the :index view" do
      expect(response).to render_template file: :index
    end
  end

  describe "GET #new" do
    let!(:manufacturer) { mock_model(Manufacturer).as_new_record }

    before { get :new }

    it "assigns a new Attribute to @attribute" do
      expect(assigns[:manufacturer]).to eq manufacturer
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database"
      it "redirects to the home page"
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :new template"
    end
  end

end
