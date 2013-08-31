require 'spec_helper'

describe Backend::UsersController do

  let!(:user) {mock_model(User).as_null_object}
  login_as_god

  describe "#index" do
    before :each do
      @user1, @user2 = FactoryGirl.create(:valid_user), FactoryGirl.create(:valid_user)
      get :index
    end

    it "assigns @user variable to the view" do
      expect(assigns[:user]).to include(@user1, @user2)
    end

    it "render index template" do
      expect(response).to render_template :index
    end
  end

  describe "#show" do
    before :each do
      @test_user = FactoryGirl.create(:valid_user)
      User.stub(:find).and_return(user)
    end

    it "sends find" do
      User.should_receive(:find).with(@test_user.id.to_s)
      get :show, id: @test_user
    end

    it "assigns @user to view" do
      get :show, id: @test_user
      expect(assigns[:user]).to eq(user)
    end

    it "render show template" do
      get :show, id: @test_user
      expect(response).to render_template :show
    end
  end

  describe "#edit" do
    before :each do
      @test_user = FactoryGirl.create(:valid_user)
      User.stub(:find).and_return(user)
    end

    it "sends find" do
      User.should_receive(:find).with(@test_user.id.to_s)
      get :edit, id: @test_user
    end

    it "assigns @user to view" do
      get :edit, id: @test_user
      expect(assigns[:user]).to eq(user)
    end

    it "render edit template" do
      get :edit, id: @test_user
      expect(response).to render_template :edit
    end
  end

  describe "#privileges" do

    let!(:role) {mock_model(Role)}

    before :each do
      @test_user = FactoryGirl.create(:valid_user)
      User.stub(:find).and_return(user)
      Role.stub(:find).and_return(role)
    end

    it "sends find" do
      User.should_receive(:find).with(@test_user.id.to_s)
      get :privileges, user_id: @test_user
    end

    it "render privileges template" do
      get :privileges, user_id: @test_user
      expect(response).to render_template :privileges
    end

    it "assigns @user to view" do
      get :privileges, user_id: @test_user
      expect(assigns[:user]).to eq user
    end

    xit "assigns @roles to view" do
      get :privileges, user_id: @test_user
      expect(assigns[:roles]).to eq role
    end
  end

  describe "#destroy" do
    before :each do
      @test_user = FactoryGirl.create(:valid_user)
      User.stub(:find).and_return(user)
    end

    it "sends find" do
      User.should_receive(:find).with(@test_user.id.to_s)
      get :destroy, id: @test_user
    end

    context "return true" do

      before :each do
        User.stub(:destroy).and_return(true)
        get :destroy, id: @test_user
      end

      it "deletes user from db" do
        expect(User.find(@test_user)).to be_nil
      end
    end

    context "return false" do
      before :each do
        User.stub(:destroy).and_return(false)
        get :destroy, id: @test_user
      end


    end
  end
end