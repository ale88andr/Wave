require 'spec_helper'

describe "testing tools run" do
  it "with rspec" do
    expect(true).to eq(true)
  end
  it "with capybara DSL" do
    visit '/'
  end
end