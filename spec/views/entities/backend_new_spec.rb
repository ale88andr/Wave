require 'spec_helper'

describe "backend/entities/new" do

  before { render }

  it "1" do
    expect(rendered).to have_content("Добавление карточки нового товара")
  end
  it { should have_content("Добавление карточки нового товара") }
  it { should render_template partial: 'form' }
  it { should have_selector("form#new_entity") }

end