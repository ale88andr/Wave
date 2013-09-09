require 'spec_helper'

describe Backend::AttributesController do

  describe "as admin" do

    shared_examples_for "record not found" do

      before { Attribute.stub(:find).and_raise(ActiveRecord::RecordNotFound) }

      it "renders the :404 template" do
        expect(response).to render_template file: 'public/404'
      end

      it "response return 404 status" do
        expect(response.status).to eq 404
      end
    end

    login_as_god

    describe "GET #index" do
      let!(:attribute) { FactoryGirl.create(:attribute) }

      before { get :index }

      it "populates an array of attributes" do
        expect(assigns[:attributes]).to eq [attribute]
      end

      it "renders the :index view" do
        expect(response).to render_template file: :index
      end
    end

    describe "GET #new" do
      let!(:attribute) { stub_model(Attribute).as_new_record }

      before :each do
        Attribute.stub(:new).and_return(attribute)
        get :new
      end

      it "assigns a new Attribute to @attribute" do
        expect(assigns[:attribute]).to eq attribute
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new attribute in the database" do
          expect{ post :create, attribute: FactoryGirl.attributes_for(:attribute) }.to change(Attribute, :count).by(1)
        end

        it "redirects to the home page" do
          post :create, attribute: FactoryGirl.attributes_for(:attribute)
          expect(response).to redirect_to backend_attributes_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new contact in the database" do
          expect{ post :create, attribute: FactoryGirl.attributes_for(:attribute, name: nil) }.not_to change(Attribute, :count)
        end

        it "re-renders the :new template" do
          post :create, attribute: FactoryGirl.attributes_for(:attribute, name: nil)
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      context "attribute find" do
        let!(:attribute) { FactoryGirl.create(:attribute) }

        before { Attribute.stub(:find).and_return(attribute) }

        it "located the requested @attribute" do
          Attribute.should_receive(:find).with(attribute.id.to_s)
          get :edit, id: attribute
        end

        it "located the requested @attribute" do
          get :edit, id: attribute
          expect(assigns[:attribute]).to eq attribute
        end

        it "renders the :edit template" do
          get :edit, id: attribute
          expect(response).to render_template :edit
        end
      end

      context "attribute not found" do
        it_behaves_like "record not found" do
          before { get :edit, id: 1001 }
        end
      end
    end

    describe 'PUT #update' do
      let!(:attribute) { FactoryGirl.create(:attribute) }

      context "valid attributes" do
        it "located the requested @attribute" do
          put :update, id: attribute, attribute: FactoryGirl.attributes_for(:attribute)
          expect(assigns[:attribute]).to eq attribute
        end

        it "changes @attribute attributes" do
          put :update, id: attribute, attribute: FactoryGirl.attributes_for(:attribute, name: 'changed attribute', unit_id: 1001)
          attribute.reload
          attribute.name.should eq("changed attribute")
          attribute.unit_id.should eq(1001)
        end

        it "redirects to the attributes list" do
          put :update, id: attribute, attribute: FactoryGirl.attributes_for(:attribute)
          expect(response).to redirect_to backend_attributes_path
        end
      end

      context "invalid attributes" do
        it "locates the requested @attribute" do
          put :update, id: attribute, attribute: FactoryGirl.attributes_for(:attribute, name: nil)
          expect(assigns[:attribute]).to eq attribute
        end

        it "does not change @attribute's attributes" do
          put :update, id: attribute, attribute: FactoryGirl.attributes_for(:attribute, name: nil, unit_id: 1001)
          attribute.reload
          attribute.unit_id.should_not eq(1001)
        end

        it "re-renders the edit method" do
          put :update, id: attribute, attribute: FactoryGirl.attributes_for(:attribute, name: nil)
          expect(response).to render_template :edit
        end
      end

      context "attribute not found" do
        it_behaves_like "record not found" do
          before { put :update, id: 1001, attribute: attribute }
        end
      end
    end

    describe 'DELETE destroy' do
      let!(:attribute) { FactoryGirl.create(:attribute) }

      it "deletes the attribute" do
        expect{ delete :destroy, id: attribute }.to change(Attribute,:count).by(-1)
      end

      it "redirects to attributes#index" do
        delete :destroy, id: attribute
        expect(response).to redirect_to backend_attributes_path
      end

      context "attribute not found" do
        it_behaves_like "record not found" do
          before { delete :destroy, id: 1001 }
        end
      end
    end
  end
end