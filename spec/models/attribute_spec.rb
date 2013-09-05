require 'spec_helper'

describe Attribute do
  subject { Attribute.new }

  it { should respond_to :name }
  it { should respond_to :unit_id }

  context "HABTM assosiation" do
    it { should respond_to :entity_category_ids }
  end

  describe "validation" do
    context "with valid params" do
      it "should be true" do
        expect(FactoryGirl.build(:attribute)).to be_valid
      end
    end

    context "with invalid params" do
      it "with empty name" do
        expect(FactoryGirl.build(:attribute, name: nil)).not_to be_valid
      end

      it "with too long name" do
        expect(FactoryGirl.build(:attribute, name: 'a' * 150)).not_to be_valid
      end
    end
  end
end