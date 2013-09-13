require 'spec_helper'

describe Backend::EntitiesController do
  it { expect(Backend::EntitiesController.superclass).to eq Backend::ApplicationController }

  describe "as admin" do

    login_as_god

    it { expect{current_user.role? :admin}.to be_true }

    shared_examples_for "record not found" do
      before { Attribute.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "renders the :404 template" do
        expect(response).to render_template file: 'public/404'
      end
    end

    describe "GET #select" do
      subject { get :select }

      it { should render_template :select }
    end

    describe "GET #new" do

      let!(:entity) { stub_model(Entity).as_new_record }

      context "without params" do
        subject { get :new }

        it { should redirect_to  select_backend_entities_path }
      end

      context "with params" do
        before { Entity.stub(:new).and_return(entity) }

        subject(:resp) { get :new, entity: {category_id: 1} }

        it "locates @entity to template" do
          resp and expect(assigns[:entity]).to eq entity
        end

        it { expect(resp).to render_template :new }
      end
    end

    describe "POST #create" do
      let!(:entity) { stub_model(Entity) }
      let!(:e) { FactoryGirl.attributes_for(:entity) }

      context "object" do
        before { Entity.stub(:new).and_return(entity) }
        after { post :create, entity: e }

        it "receive .new with params" do
          Entity.should_receive(:new).and_return(e)
        end

        it "receive .save" do
          entity.should_receive(:save)
        end
      end

      context "save return true" do
        subject(:resp) { post :create, entity: e }

        it { expect{resp}.to change(Entity, :count).by(1) }
        it { expect(resp).to redirect_to backend_entity_path(Entity.last) }
        it { resp and expect(flash[:notice]).to be }
      end

      context "save return false" do
        subject(:resp) { post :create }

        it { expect{resp}.not_to change(Entity, :count) }
        it { expect(resp).to render_template :new }
        it { resp and expect(flash[:error]).to be }
      end
    end

    describe "GET #show" do
      let!(:entity) { FactoryGirl.create(:entity) }

      before { Entity.stub(:find).and_return(entity) }

      it "receive .find" do
        Entity.should_receive(:find).with(entity.id.to_s)
        get :show, id: entity.id
      end

      subject(:resp) { get :show, id: entity.id }

      context ".find return true" do
        it { expect(resp).to render_template :show }
        it "locates @entity" do
          resp and expect(assigns[:entity]).to eq entity
        end
      end

      context ".find return false" do
        it_behaves_like "record not found" do
          before { get :show, id: 1001 }
        end
      end
    end

    describe "GET #index" do
      let!(:entities) { FactoryGirl.create(:entity) }
      subject(:resp) { get :index }

      it { resp and expect(assigns[:entities]).to eq [entities] }
      it { should render_template :index }
    end

  end
end