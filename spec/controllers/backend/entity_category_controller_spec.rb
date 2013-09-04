require 'spec_helper'

describe Backend::EntityCategoryController do
  
  let!(:category) { stub_model(EntityCategory).as_null_object }
  let!(:test_category) { FactoryGirl.create(:entity_category) }

  describe "with admin || manager role" do
    login_as_god

    it "have admin privileges" do
      expect{current_user.role? :admin}.to be_true
    end

    describe "#index" do
      before { get :index }

      it "reneder index template" do
        expect(response).to render_template :index
      end

      it "assigns @category to view" do
        expect(assigns[:categories]).to include(test_category)
      end
    end

    describe "#new" do

    end
  end

  describe "with user role" do

  end
end