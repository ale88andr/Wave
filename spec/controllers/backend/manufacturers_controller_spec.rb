require 'spec_helper'

describe Backend::ManufacturersController do

  it { expect(Backend::ManufacturersController.superclass).to eq Backend::ApplicationController }

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

      before { Manufacturer.stub(:find_by_id).and_raise(ActiveRecord::RecordNotFound) }

      it "renders the :404 template" do
        expect(response).to render_template file: 'public/404'
      end

      it "response return 404 status" do
        expect(response.status).to eq 404
      end
    end

    login_as_god

    describe "GET #index" do
      let!(:manufacturer) { FactoryGirl.create(:manufacturer) }

      before { get :index }

      it "populates an array of manufacturers" do
        expect(assigns[:manufacturers]).to eq [manufacturer]
      end

      it "renders the :index view" do
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      let!(:manufacturer) { stub_model(Manufacturer).as_new_record }

      before :each do
        Manufacturer.stub(:new).and_return(manufacturer)
        get :new
      end

      it "assigns a new manufacturer to @manufacturer" do
        expect(assigns[:manufacturer]).to eq manufacturer
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new manufacturer in the database" do
          expect{ post :create, manufacturer: FactoryGirl.attributes_for(:manufacturer) }.to change(Manufacturer, :count).by(1)
        end

        it "redirects to the home page" do
          post :create, manufacturer: FactoryGirl.attributes_for(:manufacturer)
          expect(response).to redirect_to backend_manufacturers_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new manufacturer in the database" do
          expect{ post :create, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: nil) }.not_to change(Attribute, :count)
        end

        it "re-renders the :new template" do
          post :create, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: nil)
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      context "manufacturer find" do
        let!(:manufacturer) { FactoryGirl.create(:manufacturer) }

        before { Manufacturer.stub(:find).and_return(manufacturer) }

        it "located the requested @manufacturer" do
          Manufacturer.should_receive(:find).with(manufacturer.id.to_s)
          get :edit, id: manufacturer
        end

        it "located the requested @manufacturer" do
          get :edit, id: manufacturer
          expect(assigns[:manufacturer]).to eq manufacturer
        end

        it "renders the :edit template" do
          get :edit, id: manufacturer
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
      let!(:manufacturer) { FactoryGirl.create(:manufacturer) }

      context "valid attributes" do
        it "located the requested @manufacturer" do
          put :update, id: manufacturer, manufacturer: FactoryGirl.attributes_for(:manufacturer)
          expect(assigns[:manufacturer]).to eq manufacturer
        end

        it "changes @manufacturer attributes" do
          put :update, id: manufacturer, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: 'changed attribute', url: 'www.manufacturer.com')
          manufacturer.reload
          manufacturer.name.should eq('changed attribute')
          manufacturer.url.should eq('www.manufacturer.com')
        end

        it "redirects to the manufacturer list" do
          put :update, id: manufacturer, manufacturer: FactoryGirl.attributes_for(:manufacturer)
          expect(response).to redirect_to backend_manufacturers_path
        end
      end

      context "invalid attributes" do
        it "locates the requested @manufacturer" do
          put :update, id: manufacturer, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: nil)
          expect(assigns[:manufacturer]).to eq manufacturer
        end

        it "does not change @manufacturer's attributes" do
          put :update, id: manufacturer, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: nil, url: 'www.manufacturer.com')
          manufacturer.reload
          manufacturer.url.should_not eq('www.manufacturer.com')
        end

        it "re-renders the edit method" do
          put :update, id: manufacturer, manufacturer: FactoryGirl.attributes_for(:manufacturer, name: nil)
          expect(response).to render_template :edit
        end
      end

      context "attribute not found" do
        it_behaves_like "record not found" do
          before { put :update, id: 1001, manufacturer: manufacturer }
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:manufacturer) { FactoryGirl.create(:manufacturer) }

      it "deletes the manufacturer" do
        expect{ delete :destroy, id: manufacturer }.to change(Manufacturer,:count).by(-1)
      end

      it "redirects to manufacturers#index" do
        delete :destroy, id: manufacturer
        expect(response).to redirect_to backend_manufacturers_path
      end

      context "manufacturer not found" do
        it_behaves_like "record not found" do
          before { delete :destroy, id: 1001 }
        end
      end
    end
  end

  describe "as user" do

    login_as_user

    it "have user privileges" do
      expect{current_user.role? :user}.to be_true
    end

    let!(:manufacturer) { FactoryGirl.create(:manufacturer) }

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
        before { get :edit, id: manufacturer }
      end
    end

    describe "#destroy" do
      it_behaves_like "access denyed" do
        before { delete :destroy, id: manufacturer }
      end
    end

    describe "#update" do
      it_behaves_like "access denyed" do
        before { put :update, id: manufacturer, manufacturer: manufacturer }
      end
    end
  end
end
