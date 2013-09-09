require 'spec_helper'

describe Backend::CategoriesController do

  it { expect(Backend::AttributesController.superclass).to eq Backend::ApplicationController }


  let!(:category) { mock_model(Category).as_null_object }
  let!(:test_category) { FactoryGirl.create(:category) }

  shared_examples_for "access denyed" do
    it "redirect to root" do
      expect(response).to redirect_to root_path
    end

    it "render alert" do
      expect(flash[:alert]).not_to be_nil
    end
  end

  describe "as admin" do

    shared_examples_for "record not found" do

      before { Category.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "renders the :404 template" do
        expect(response).to render_template file: 'public/404'
      end

      it "response return 404 status" do
        expect(response.status).to eq 404
      end
    end

    login_as_god

    it "have admin privileges" do
      expect{current_user.role? :admin}.to be_true
    end

    describe "GET #index" do

      before { get :index }

      it "reneder :index template" do
        expect(response).to render_template :index
      end

      it "assigns @categories to view" do
        expect(assigns[:categories]).to include(test_category)
      end
    end

    describe "GET #new" do
      before :each do
        Category.stub(:new).and_return(category)
        get :new
      end

      it "reneder :new template" do
        expect(response).to render_template :new
      end

      it "assigns @category to view" do
        expect(assigns[:category]).to eq category
      end
    end

    describe "POST #create" do
      before { Category.stub(:new).and_return(category) }

      context "when save return true" do
        before :each do
          Category.stub(:save).and_return(true)
          post :create, category: test_category
        end

        it "reneder :index template" do
          expect(response).to redirect_to backend_categories_path
        end

        it "with flash message" do
          expect(flash[:notice]).not_to be_nil
        end
      end

      context "when save return false" do
        before :each do
          Category.stub(:save).and_return(false)
          post :create, category: test_category
        end

        it "reneder :index template" do
          expect(response).to render_template file: 'new'
        end

        it "with error flash message" do
          expect(flash[:notice]).not_to be_nil
        end
      end
    end

    describe "DELETE #destroy" do
      context "return true" do
        before { Category.stub(:destroy).and_return true }

        it "delete category from database" do
          expect{ delete :destroy, id: test_category }.to change(Category, :count).by(-1)
        end

        it "redirect to :index template" do
          expect(delete :destroy, id: test_category).to redirect_to backend_categories_path
        end
      end

      context "category not found" do
        it_behaves_like "record not found" do
          before { delete :destroy, id: 1001 }
        end
      end
    end

    describe "GET #edit" do
      context "category exists" do
        before { get :edit, id: test_category }

        it "locates @category to view" do
          expect(assigns[:category]).to eq test_category
        end

        it "reneder :edit template" do
          expect(response).to render_template :edit
        end
      end

      context "category not exists" do
        it_behaves_like "record not found" do
          before { get :edit, id: test_category }
        end
      end
    end

    describe "PUT #update" do
      context "with valid attributes" do
        before { put :update, id: test_category, category: FactoryGirl.attributes_for(:category, name: 'Changed category') }

        it "locates the requested @category" do
          expect(assigns[:category]).to eq test_category
        end

        it "change category attributes" do
          test_category.reload
          expect(test_category.name).to eq 'Changed category'
        end

        it "redirects to :index template" do
          expect(response).to redirect_to backend_categories_path
        end
      end

      context "with invalid attributes" do
        before { put :update, id: test_category, category: FactoryGirl.attributes_for(:category, name: nil) }

        it "locates the requested @category" do
          expect(assigns[:category]).to eq test_category
        end

        it "renders :edit template" do
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe "as user" do

    login_as_user

    it "have user privileges" do
      expect{current_user.role? :user}.to be_true
    end

    let!(:attribute) { FactoryGirl.create(:attribute) }

    describe "#index" do
      it_behaves_like "access denyed" do
        before { get :index }
      end
    end

    describe "#new" do
      it_behaves_like "access denyed" do
        before { get :new }
      end
    end

    describe "#edit" do
      it_behaves_like "access denyed" do
        before { get :edit, id: attribute }
      end
    end

    describe "#destroy" do
      it_behaves_like "access denyed" do
        before { delete :destroy, id: attribute }
      end
    end

    describe "#update" do
      it_behaves_like "access denyed" do
        before { put :update, id: attribute, user: attribute }
      end
    end
  end
end