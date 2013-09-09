require 'spec_helper'

describe "backend/categories/new" do
  before { render }

  context "render" do
    it { expect(rendered).to have_content("Создание новой категории товаров ") }

    it "with new entity category form" do
      expect(rendered).to have_selector("form#new_entity_category")
    end

    context "form" do
      it "with name field" do
        expect(rendered).to have_field "entity_category[name]", type: 'text'
      end

      it "with active checbox" do
        expect(rendered).to have_checked_field "entity_category[active]"
      end

      it "with parent category select" do
        expect(rendered).to have_select "entity_category[parent_id]"
      end

      it "with sign in button" do
        expect(rendered).to have_button("Создать категорию")
      end
    end
  end
end