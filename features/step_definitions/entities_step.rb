# Scenario: Visiting #select
Given /^there are created the following categories:$/ do |categories|
  categories.hashes.map do |category|
    FactoryGirl.create(:category, name: category)
  end
end

When /^I go to the entity new link$/ do
  visit select_backend_entities_path
  expect(current_path).to eq '/backend/entities/select'
end

Then /^I should see a page with category selector which include:$/ do |categories|
  categories.hashes.map do |category|
    expect(page).to have_select("entity[category_id]")
  end
end

And /^I should see button to continue$/ do
  expect(page).to have_button("Выбрать")
end
# --end Scenario: Visiting #select

# Scenario: Adding new entity
And /^There are created the following attributes in (.+) category$/ do |category, attributes|
  attributes.hashes.map do |attribute|
    FactoryGirl.create(:attribute, name: attribute, )
  end
end

When /^I go to the entity new link$/ do

end

And /^I choose category "Displays"$/ do

end

And /^I click commit button$/ do

end

Then /^I should be redirected to new entity form with "Displays" catetegory attributes$/ do

end
# --end Scenario: Adding new entity
