# temporary here
When /^(?:I am|I'm|I) (?:on|visit|go to|visiting) ['"]?([^"']*)["']$/ do |path|
  url_translate = {
    "Entity backend page" => backend_entities_path,
    "New Entity backend page" => new_backend_entity_path,
    "Entity category select backend page" => select_backend_entities_path,
  }
  if url_translate.key?(path)
    visit url_translate[path]
  else
    raise "#{path.inspect} not supported or not defined in application"
  end
end


# Scenario: Visiting #select
Given /^there are created the following categories:$/ do |categories|
  # creates parent/child categories
  categories.hashes.map do |category|
    FactoryGirl.create(:category, name: category[:name], parent_id: category[:parent])
  end
end

When /^I go to the entity new link$/ do
  visit select_backend_entities_path
  expect(current_path).to eq '/backend/entities/select'
end

Then /^I should see a page with category selector which include:$/ do |categories|
  categories.hashes.map do |category|
    expect(page).to have_select("entity[category_id]", with_options: [category[:name]])
    #expect(page).to have_xpath "//select[@id = '#new_entity']/option[@value = #{category['Name']}]"
  end
end

And /^I should see button to continue$/ do
  expect(page).to have_button("Выбрать")
end
# --end Scenario: Visiting #select

# Scenario: Adding new entity
And /^There are created the following attributes in (.+) category$/ do |category, attributes|
  @attr = []
  attributes.hashes.map do |attribute|
    @attr << FactoryGirl.create(:attribute, name: attribute[:name])
  end
  @category = Category.find_by_name(category)
  @category.eav_attribute_ids << @attr
end

And /^I should see a choosing categories form$/ do
  expect(page).to have_content("Создание товара / Выбор категории :")
  expect(page.find("#new_entity")).to be
  within "#new_entity" do
    expect(page).to have_select("entity[category_id]")
    expect(page).to have_button("Выбрать")
  end
end

But /^(.+) category should be disabled$/ do |category|
  within "#new_entity" do
    expect(have_select("entity[category_id]", disabled: category)).to be
  end
end

Then /^I select category (.+) and click commit button$/ do |category|
  within "#new_entity" do
    select(category, from: "entity[category_id]")
    click_button("Выбрать")
  end
end

And /^I should be redirected to new entity form with ["'](.+)['"] catetegory attributes$/ do |category|
  @category = Category.find_by_name(category)
  expect(current_path).to eq new_backend_category_entity_path(@category)
  expect(page).to have_content "Добавление нового товара :"
  expect(page).to have_content @category.name
  @category.eav_attributes.each_with_index do |attr, index|
    expect(page).to have_selector("lable", text: attr.name)
    expect(page).to have_field("entity[parameters_attributes][#{index}][value]", type: 'text')
  end
  expect(page).to have_button("Добавить товар")
end
# --end Scenario: Adding new entity

# Scenario: Filling new entity form with valid data

And /^There are created the following technologies:$/ do |technologies|
  technologies.hashes.map do |technology|
    FactoryGirl.create(:technology, name: technology[:name])
  end
end

And /^I visit new entity form$/ do
  step "I go to 'New Entity backend page'"
  step "I should see a choosing categories form"
  step "I select category Displays and click commit button"
end
# --end Scenario: Filling new entity form with valid data