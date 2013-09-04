# Scenario: View list of all categories
And /^Any categories are exists$/ do
	@categories = FactoryGirl.create(:entity_category)
	expect(EntityCategory.find(@categories.id)).not_to be_nil
end

When /^I visit backend categories path$/ do
	visit 'backend/category'
	expect(current_path).to eq backend_category_index_path
end

Then /^I should see list of categories$/ do
	expect(page).to have_content "Список доступных категорий:"
  within ".little-table" do
  	expect(page).to have_content @categories.name
  end
end

And /^I should see categories control$/ do
	expect(page).to have_link "Создать новою категорию", href: new_backend_category_path
end
# --end Scenario: View list of all categories 