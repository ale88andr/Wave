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
  expect(page).to have_link "Редактировать", href: edit_backend_category_path(@categories)
  expect(page).to have_link "Удалить", href: backend_category_path(@categories)
end
# --end Scenario: View list of all categories

# Scenario: New category of product
When /^I visit new category path$/ do
  visit 'backend/category/new'
  expect(current_path).to eq new_backend_category_path
end

Then /^I should see a form which creates new category$/ do
  expect(page).to have_selector "h3", text: "Создание новой категории товаров :"
  within "#new_category" do
    expect(page).to have_field "category[name]", type: 'text'
    expect(page).to have_checked_field "category[active]"
    expect(page).to have_select "category[parent_id]"
    expect(page).to have_button "Создать категорию"
  end
end

And /^I should see a link controls$/ do
  expect(page).to have_link "Назад"
  expect(page).to have_link "К списку категорий", href: backend_category_index_path
end
# --end Scenario: New category of product

# Scenario: Create new category of product
And /^I visit new category form$/ do
  step "I visit new category path"
  step "I should see a form which creates new category"
end

And /^I filing new category form with valid data$/ do
  @new_category = FactoryGirl.attributes_for(:entity_category)
  within "#new_category" do
    fill_in "category[name]", with: @new_category[:name]
    fill_in "category[description]", with: @new_category[:description]
    check 'Видимая категория'
    select('Нет', from: 'category[parent_id]')
  end
end

When /^I click new category button category should created$/ do
  expect{ click_button 'Создать категорию' }.to change(EntityCategory, :count).by(1)
end

Then /^I should redirects to index category path$/ do
  expect(current_path).to eq backend_category_index_path
end

And /^I should see new category in the list of category$/ do
  expect(page).to have_content @new_category[:name]
end
# --end Scenario: Create new category of product
