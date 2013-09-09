require 'spec_helper'

describe Manufacturer do

  subject { Manufacturer.new }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :url }
  it { should respond_to :image }

  context "validation" do
    context "valid data" do
      it { expect(FactoryGirl.build(:manufacturer)).to be_valid }

      it "with empty url" do
        expect(FactoryGirl.build(:manufacturer, url: nil)).to be_valid
      end

      it "with true url format" do
        valid_urls = ['www.example.com', 'example.ua', 'www.e1.']
        valid_urls.each do |url|
          expect(FactoryGirl.build(:manufacturer, url: url)).to be_valid
        end
      end
    end

    context "invalid data" do
      it "with empty name" do
        expect(FactoryGirl.build(:manufacturer, name: nil)).not_to be_valid
      end

      it "with wrong url" do
        expect(FactoryGirl.build(:manufacturer, url: "example")).not_to be_valid
      end
    end
  end

end
