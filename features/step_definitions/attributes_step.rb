# Scenario: Visiting a list of attributes
Given /^there are created the following attributes:$/ do |attributes|
  attributes.hashes.map do |attribute|
    FactoryGirl.create(:attribute, name: attribute)
  end
end

When /^I (?:visit|go to) the attributes index page$/ do
  visit 'backend/attributes'
end

Then /^I should see a list existing attributes:$/ do |attributes|
  attributes.hashes.map do |attribute|
    expect(page).to have_content 'b', text: attribute
  end
end

And /^I should see link to new attribute$/ do
  expect(page).to have_link "Создать новый аттрибут", href: new_backend_attribute_path
end
# --end Scenario: Visiting a list of attributes

# Scenario: Adding new attribute
When /^I visit new attribute link$/ do
  visit new_backend_attribute_path
end

Then /^I should see a new attribute form$/ do
  expect(current_path).to eq '/backend/attributes/new'
  within '#new_attribute' do
    expect(page).to have_field "attribute[name]", type: 'text'
    expect(page).to have_select "attribute[unit_id]"
    expect(page).to have_button "Создать аттрибут"
  end
end

And /^I should see extra controls$/ do
  within '.sub-nav' do
    expect(page).to have_link "Назад"
    expect(page).to have_link "К списку аттрибутов", href: backend_attributes_path
    expect(page).to have_link "К списку категорий", href: backend_categories_path
    expect(page).to have_link "Создать единицу измерения", href: new_backend_unit_path
  end
end
# --end Scenario: Adding new attribute

# Scenario: Create new attribute with valid params
Given /^I visiting new attribute form$/ do
  step "I visit new attribute link"
  step "I should see a new attribute form"
  step "I should see extra controls"
end

When /^I fill in new attribute form with attribute name (.+)$/ do |attribute_name|
  within "#new_attribute" do
    fill_in "attribute[name]", with: attribute_name
  end
end

Then /^After click on submit button new attribute (.+) should be added in database$/ do |attribute_name|
  expect{ find('input[type=submit][name=commit]').click }.to change(Attribute, :count).by(1)
  expect(Attribute.find_by_name(attribute_name)).not_to be_nil
end

And /^I redirects to the attributes index page$/ do
  expect(current_path).to eq backend_attributes_path 
end

And /^I should (.+) attribute on page$/ do |attribute_name|
  expect(page).to have_content 'b', text: attribute_name
end
# --end Scenario: Create new attribute with valid params

# Scenario: Create new attribute with invalid params
When /^I fill in new attribute form without attribute name$/ do
  within "#new_attribute" do
    fill_in "attribute[name]", with: nil
  end
end

Then /^After click on submit button attribute should not be added in database$/ do
  expect{ find('input[type=submit][name=commit]').click }.not_to change(Attribute, :count)
end

Then /^I should see new attribute form again$/ do
  step "I visiting new attribute form"
end

And /^I should see error message$/ do
  expect(page).to have_text "Не удалось создать аттрибут!"
end
# --end Scenario: Create new attribute with invalid params

# Scenario: Editing attribute params
Given /^(.+) attribute created$/ do |attribute_name|
  @attribute = FactoryGirl.create(:attribute, name: attribute_name)
end

And /^I visit attribute editing form$/ do
  visit edit_backend_attribute_path(@attribute)
end

When /^I fill in new attribute name (.+) in editing form$/ do |attribute_name|
  expect(current_path).to eq "/backend/attributes/#{@attribute.id}/edit"
  expect(page).to have_selector "h3", text: "Редактирование аттрибута '#{@attribute.name}' :"
  within "#edit_attribute_#{@attribute.id}" do
    expect(page.find_field('attribute_name').value).to eq @attribute.name
    fill_in "attribute[name]", with: attribute_name
  end
end

Then /^I click on submit button attribute name should be changed to (.+)$/ do |attribute_name|
  find('input[type=submit][name=commit]').click
  expect(Attribute.find_by_name(attribute_name)).not_to be_nil
end

And /^I should see success message that attribute (.+) updated$/ do |attribute_name|
  expect(current_path).to eq backend_attributes_path
  expect(page).to have_content "Аттрибут '#{attribute_name}' обновлен!"
end
# --end Scenario: Editing attribute params

# Scenario: Deleting attribute
When /^I click (.+) delete link attribute should be deleting from database$/ do |attribute_name|
  expect{ click_link("Удалить", href: backend_attribute_path(@attribute)) }.to change(Attribute, :count).by(-1)
end

And /^I should see notice message that attribute deletes$/ do
  expect(page).to have_content "Аттрибут удалён"
end
# --end Scenario: Deleting attribute