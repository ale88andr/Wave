require 'spec_helper'

describe "backend/entities/new" do

  let!(:entity) { stub_model(Entity).as_new_record }
  let(:attributes) { 3.times{FactoryGirl.create(:attribute)} }
  let(:category) { FactoryGirl.create(:category, attributes: attributes) }

  before :each do
    assign(:category, category)
    assign(:entity, entity)
    render
  end

  subject { rendered }

  it { should have_content("Добавление карточки нового товара") }
  
  # templates
  it { should render_template 'form' }
  it { should render_template :new }
  it { should render_template 'backend/parameters/_form' }

  # form
  it { should have_selector("form#new_entity") }

  context "rendered form" do
    # main info
    it { should have_field("entity[name]", type: "text") }
    it { should have_field("entity[description]") }
    it { should have_field("entity[availability]", type: "number") }
    it { should have_field("entity[guarantee]", type: "number") }
    it { should have_checked_field("entity[published]") }
    it { should have_select("entity[manufacturer_id]") }
    xit { expect(find("#entity_category_id").value).to eq category.id }

    # price
    it { should have_field("entity[price]", type: "number") }
    it { should have_unchecked_field("entity[bind_price]") }
    it { should have_field("entity[price_in_currency]", type: "number", disabled: true) }
    it { should have_select("entity[price_start_date(1i)]") }
    it { should have_select("entity[price_start_date(2i)]") }
    it { should have_select("entity[price_start_date(3i)]") }
    it { should have_select("entity[price_end_date(1i)]") }
    it { should have_select("entity[price_end_date(2i)]") }
    it { should have_select("entity[price_end_date(3i)]") }

    # attributes
    context "build category attributes" do

      it "attributes id" do
        category.eav_attributes.each_with_index do |attribute, index|
          expect(find("entity[parameters_attributes][#{index}][attribute_id]").value).to eq attribute.id
        end
      end

      it "values" do
        category.eav_attributes.each_with_index do |attribute, index|
          expect(rendered).to have_field("entity[parameters_attributes][#{index}][value]", type: "text")
        end
      end
    end

    # controls
    it { should have_button("Добавить товар") }
    it { should have_link('К списку категорий', href: backend_categories_path) }
    it { should have_link('Создать аттрибут', href: new_backend_attribute_path) }
    it { should have_link('К перечню аттрибутов', href: backend_attributes_path) }
  end

end