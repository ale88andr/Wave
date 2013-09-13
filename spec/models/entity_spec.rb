require 'spec_helper'

describe Entity do
  subject { Entity.new }

  it { should respond_to :additional_shiping_cost }
  it { should respond_to :advise }
  it { should respond_to :availability }
  it { should respond_to :bind_price }
  it { should respond_to :characteristics }
  it { should respond_to :description }
  it { should respond_to :guarantee }
  it { should respond_to :image }
  it { should respond_to :name }
  it { should respond_to :price }
  it { should respond_to :price_end_date }
  it { should respond_to :price_in_currency }
  it { should respond_to :price_start_date }
  it { should respond_to :views }
  it { should respond_to :rate }
  it { should respond_to :published }

  describe "relations" do
    it { should respond_to :category }
    it { should respond_to :attributes }
    it { should respond_to :parameters }
    it { should respond_to :manufacturer }
  end

  describe "validations" do
    context "with true data" do
      it { FactoryGirl.build(:entity).should be_valid }
    end

    context "fails" do
      it "with empty name" do
        expect(FactoryGirl.build(:entity, name: nil)).not_to be_valid
      end

      it "with dublicate name" do
        FactoryGirl.create(:entity, name: 'Entity')
        expect(FactoryGirl.build(:entity, name: 'Entity')).not_to be_valid
      end

      it "with guarantee is string" do
        expect(FactoryGirl.build(:entity, guarantee: 'String')).not_to be_valid
      end

      it "with availability less zero" do
        expect(FactoryGirl.build(:entity, availability: -1)).not_to be_valid
      end

      it "with price less zero" do
        expect(FactoryGirl.build(:entity, price: -1)).not_to be_valid
      end

      it "with price in currency less zero" do
        expect(FactoryGirl.build(:entity, price_in_currency: -1)).not_to be_valid
      end
    end
  end
end