require 'spec_helper'

describe Backend::CategoriesController do

  let!(:category) { mock_model(Category).as_null_object }
  let!(:test_category) { FactoryGirl.create(:category) }

  describe "with admin or manager role" do
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
      before { get :new }

      it "reneder new template" do
        expect(response).to render_template :new
      end

      xit "assigns @category to view" do
        expect(assigns[:category]).to eq category
      end
    end

    describe "#create" do
      let!(:test) { FactoryGirl.attributes_for(:category, name: "another category") }

      before :each do
        Category.stub(:new).and_return(category)
      end

      xit "sends new" do
        EntityCategory.should_receive(:new).with(test)
        post :create, category: test
      end

      context "when save return true" do
        before :each do
          Category.stub(:save).and_return(true)
          post :create, category: test
        end

        it "reneder index" do
          expect{response}.to redirect_to backend_categories_path
        end

        it "with success flash message" do
          expect(flash[:notice]).not_to be_nil
        end
      end

      context "when save return false" do
        before :each do
          Category.stub(:save).and_return(false)
          post :create, category: test
        end

        it "reneder index" do
          expect(response).to render_template file: 'new'
        end

        it "with success flash message" do
          expect(flash[:notice]).not_to be_nil
        end
      end
    end

    describe "#destroy" do
      context "return true" do
        before { Category.stub(:destroy).and_return true }

        it "delete category from db" do
          expect{ delete :destroy, id: test_category }.to change(Category, :count).by(-1)
        end

        it "redirect to index" do
          expect(delete :destroy, id: test_category).to redirect_to backend_categories_path
        end
      end

      context "return false" do
        before { Category.stub(:destroy).and_return false }

        it "delete category from db" do
          expect{ delete :destroy, id: 1001 }.not_to change(Category, :count)
        end

        it "redirect to index" do
          delete :destroy, id: 1001
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe "with user role" do

  end
end