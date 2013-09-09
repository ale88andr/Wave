# Scenario: Visiting a list of attributes
Given /^(.+) attributes exists$/ do |attributes|
  attributes.split(',').each { |name| FactoryGirl.create(:attribute, name: name) }
end

When /^I visit attributes index url$/ do
  visit 'backend/attributes'
end

Then /^I should see a list of attributes which includes (.+)$/ do |attributes|
  expect(current_path).to eq backend_attributes_path
  attributes.split(',').each { |name| expect(page).to have_content name }
end

And /^I should see new attribute control$/ do
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

# Scenario: Create new attribute
Given /^I visiting new attribute form$/ do
  step "I visit new attribute link"
  step "I should see a new attribute form"
  step "I should see extra controls"
end

When /^I fill in new attribute form$/ do
  @attribute = FactoryGirl.attributes_for(:attribute)
  within "#new_attribute" do
    fill_in "attribute[name]", with: @attribute[:name]
  end
end

And /^I click submit button$/ do
  expect(click_button("Создать аттрибут")).to change(Attribute, :count).by(1)
end

Then /^I should be redirect to index attribute page$/ do
  expect(current_path).to eq backend_attributes_path 
end

And /^I should see new attribute in the list$/ do
  expect(page).to have_text @attribute[:name]
end
# --end Scenario: Create new attribute
