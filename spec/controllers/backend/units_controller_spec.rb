require 'spec_helper'

describe Backend::UnitsController do

  let!(:unit) { mock_model(Unit).as_null_object }
  let!(:test_unit) { FactoryGirl.create(:unit) }

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

      it "assigns @unit to view" do
        expect(assigns[:units]).to eq [test_unit]
      end
    end

    describe "#new" do

      let(:unit_stub) { stub_model(Unit).as_new_record }

      before { get :new }

      it "reneder new template" do
        expect(response).to render_template :new
      end

      it "assigns @unit to view" do
        expect(assigns[:unit]).to eq unit_stub
      end
    end

    describe "#create" do
      let!(:test) { FactoryGirl.attributes_for(:unit, param: "another unit") }

      before :each do
        Unit.stub(:new).and_return(unit)
      end

      it "sends new" do
        Unit.should_receive(:new)
        post :create, unit: test
      end

      context "when save return true" do
        before :each do
          Unit.stub(:save).and_return(true)
          post :create, unit: test
        end

        it "reneder index" do
          expect{response}.to redirect_to backend_units_path
        end

        it "with success flash message" do
          expect(flash[:notice]).not_to be_nil
        end
      end

      context "when save return false" do
        before :each do
          Unit.stub(:save).and_return(false)
          post :create, unit: test
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
        before { Unit.stub(:destroy).and_return true }

        it "delete category from db" do
          expect{ delete :destroy, id: test_unit }.to change(Unit, :count).by(-1)
        end

        it "redirect to index" do
          expect(delete :destroy, id: test_unit).to redirect_to backend_units_path
        end
      end

      context "return false" do
        before { Unit.stub(:destroy).and_return false }

        it "delete category from db" do
          expect{ delete :destroy, id: 1001 }.not_to change(Unit, :count)
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
