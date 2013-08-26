# Scenario: Enter to register form
Given /^I am a guest user$/ do
  visit root_path
end

And /^I should see a link to registration form$/ do
  page.should have_link("Регистрация")
end

When /^I click to the register link$/ do
  page.click_link("Регистрация")
  current_path.should == new_user_registration_path
end

Then /^I should see empty form$/ do
  expect(page).to have_content "Регистрация нового пользователя"
  within '#new_user' do
    expect(page.find_field('user[name]')).not_to be_nil
    expect(page.find_field('user[email]')).not_to be_nil
    expect(page.find_field('user[password]')).not_to be_nil
    expect(page.find_field('user[password_confirmation]')).not_to be_nil
    expect(page.find_button('Присоединиться')).not_to be_nil
  end
end

And /^links to sign in, password forgot menu$/ do
  expect(page).to have_link "Войти"
  expect(page).to have_link "Забыли свой пароль?"
end
# --end Scenario: Enter to register form

# Scenario: User filling form with valid data
Given /^I am a guest user visiting registration form$/ do
  step "I am a guest user"
  step "I should see a link to registration form"
  step "I click to the register link"
end

When /^I filing registration form with valid data$/ do
  @user = FactoryGirl.attributes_for(:valid_user)
  within '#new_user' do
    fill_in('user[name]', with: @user[:name])
    fill_in('user[email]', with: @user[:email])
    fill_in('user[password]', with: @user[:password])
    fill_in('user[password_confirmation]', with: @user[:password_confirmation])
  end
end

Then /^I click on sign up button and should be added to site database$/ do
  expect{click_button('Присоединиться')}.to change(User, :count).by(1)
  expect(User.find_by_name(@user[:name])).not_to be_nil
end

And /^I should be redirected to home page with success notice$/ do
  expect(current_path).to eq root_path
  expect(page).to have_content @user[:name]
  expect(page).to have_link 'Выйти'
end
# --end Scenario: User filling form with valid data

# Scenario: User filling form with invalid data
When /^I filing registration form with invalid data$/ do
  @user = FactoryGirl.attributes_for(:invalid_user)
  within '#new_user' do
    fill_in('user[name]', with: @user[:name])
    fill_in('user[email]', with: @user[:email])
    fill_in('user[password]', with: @user[:password])
    fill_in('user[password_confirmation]', with: @user[:password_confirmation])
  end
end

Then /^I click on sign up button and should not be added to database$/ do
  expect{click_button('Присоединиться')}.not_to change(User, :count)
  expect(User.find_by_name(@user[:email])).to be_nil
end

And /^I should be redirected to register page with error$/ do
  expect(current_path).to eq '/'
  step "I should see empty form"
end

But /^Form fields should be fill in with values$/ do
  within '#new_user' do
    expect(page.find_field('user[name]').value).to eq ""
    expect(page.find_field('user[email]').value).to eq @user[:email]
  end
end
# --end Scenario: User filling form with invalid data