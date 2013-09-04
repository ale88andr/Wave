# == Schema Information
#
# Table name: entity_categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  active      :boolean          default(TRUE)
#  parent_id   :integer          default(0), not null
#

require 'spec_helper'

describe EntityCategory do
  subject { EntityCategory.new }

  it{ should respond_to :name }
  it{ should respond_to :description }
  it{ should respond_to :active }
  it{ should respond_to :parent_id }

  context "validation" do
    context "with valid attributes" do
      it "should be valid" do
        expect(FactoryGirl.build(:entity_category)).to be_valid
      end
    end

    context "with invalid attributes" do
      it "when name is empty" do
        expect(FactoryGirl.build(:entity_category, name: nil)).not_to be_valid
      end

      it "when name too long" do
        expect(FactoryGirl.build(:entity_category, name: 'a' * 55)).not_to be_valid
      end

      it "when name dublicate" do
        FactoryGirl.create(:entity_category)
        expect(FactoryGirl.build(:entity_category)).not_to be_valid
      end
    end
  end
end
