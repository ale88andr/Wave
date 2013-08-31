require 'spec_helper'

describe ProfilesController do
  context "#show" do
    let(:user) { FactoryGirl.create(:valid_user) }
    let(:profile) { stub_model(Profile).as_null_object }

    before :each do
      User.stub(:find).and_return(user)
    end

    it "sends find from user" do
      User.should_receive(:find).with(user.id.to_s)
      get :show, id: user
    end

    context "template" do
      it "render show template" do
        get :show, id: user
        expect(response).to render_template(:show)
      end

      it "assigns @user variable" do
        get :show, id: user
        expect(assigns[:user]).to eq(user)
      end
    end
  end
end