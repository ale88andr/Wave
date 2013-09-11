require 'spec_helper'

describe Backend::EntitiesController do
  it { expect(Backend::EntitiesController.superclass).to eq Backend::ApplicationController }

  describe "as admin" do

    login_as_god

    it { expect{current_user.role? :admin}.to be_true }

    describe "#new" do

      let!(:entity) { stub_model(Entity).as_new_record }

      before do
        Entity.stub(:new).and_return(entity)
        get :new
      end

      it "locates @entity to view" do
        expect(assigns[:entity]).to eq entity
      end

      it "render :new template" do
        expect(response).to render_template :new
      end
    end

  end
end