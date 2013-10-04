# == Schema Information
#
# Table name: units
#
#  id    :integer          not null, primary key
#  param :string(255)
#

require 'spec_helper'

describe Unit do
  subject { Unit.new }

  it { should respond_to :param }
  it { should respond_to :attributes_id }

  context "Has many assosiation" do
    it { should respond_to :attributes }
  end

  describe "validation" do
    context "with valid params" do
      it "should be true" do
        expect(FactoryGirl.build(:unit)).to be_valid
      end
    end

    context "with invalid params" do
      it "with empty name" do
        expect(FactoryGirl.build(:unit, param: nil)).not_to be_valid
      end

      it "with too long name" do
        expect(FactoryGirl.build(:unit, param: 'a' * 51)).not_to be_valid
      end
    end
  end
end
