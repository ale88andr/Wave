def sign_in user
  visit new_user_session_path
  within '#new_user' do
    fill_in('user[name]', with: user.name)
    fill_in('user[password]', with: user.password)
  end
  click_button("Войти")
end

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
  expect(page).to have_content "Регистрация пользователя"
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
  FactoryGirl.create(:user_role)
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

# Scenario: Enter to sign in form
Given /^I am a register user$/ do
  @user_with_account = FactoryGirl.create(:valid_user)
  visit root_path
end

And /^I should see a link to sign in form$/ do
  page.should have_link("Войти")
end

When /^I click to the sign in link$/ do
  page.click_link("Войти")
  expect(current_path).to eq new_user_session_path
end

Then /^I should see form$/ do
  expect(page).to have_content "Вход в аккаунт"
  within '#new_user' do
    expect(page.find_field('user[name]')).not_to be_nil
    expect(page.find_field('user[password]')).not_to be_nil
    expect(page.find_button('Войти')).not_to be_nil
  end
end

And /^links to sign up, password forgot menu$/ do
  expect(page).to have_link "Регистрация"
  expect(page).to have_link "Забыли свой пароль?"
end
# --end Scenario: Enter to sign in form

# Scenario: User account exists
Given /^I am a register user visiting sign in form$/ do
  step "I am a register user"
  step "I should see a link to sign in form"
  step "I click to the sign in link"
end

When /^I filing sign in form with valid data$/ do
  within '#new_user' do
    fill_in('user[name]', with: @user_with_account.name)
    fill_in('user[password]', with: @user_with_account.password)
  end
end

Then /^I click on sign in button be redirected to home page with success notice$/ do
  click_button("Войти")
  expect(current_path).to eq root_path
end

And /^I should and should be entered in my account$/ do
  expect(page).to have_content @user_with_account[:name]
end
# --end Scenario: User account exists

# Scenario: User does not have account
Given /^I am a guest user visiting sign in form$/ do
  step "I am a guest user"
  step "I should see a link to sign in form"
  step "I click to the sign in link"
end

When /^I filing sign in form with invalid data$/ do
  within '#new_user' do
    fill_in('user[name]', with: "non_existing_user_name")
    fill_in('user[password]', with: "")
  end
end

Then /^I click on sign in button and should not be enter in account$/ do
  click_button("Войти")
  expect(page).not_to have_content "non_existing_user_name"
end

And /^I should be redirected to sign in form with error$/ do
  expect(current_path).to eq new_user_session_path
end
# --end Scenario: User does not have account

# Scenario: Visit single user profile by guest user
When /^I visit any user profile$/ do
  @user_account = FactoryGirl.create(:valid_user, profile: FactoryGirl.build(:profile))
  visit profile_path @user_account
end

Then /^I should see this user info$/ do
  expect(current_path).to eq profile_path @user_account
  expect(page).to have_content "Просмотр профиля пользователя \"#{@user_account.name}\""
end

But /^I should not see its account controls$/ do
  expect(page).not_to have_link "Редактировать свой профиль", href: '/edit'
  expect(page).not_to have_button "Удалить мой аккаунт"
end
# --end Scenario: Visit single user profile by registered user

# Scenario: Visit single user profile by registered user
Given /^I am a sign in user$/ do
  step "I am a register user"
  sign_in @user_with_account
end

But /^If this is my profile I should see account controls$/ do
  expect(page).to have_button "Удалить мой аккаунт"
  expect(page).to have_link "Редактировать свой профиль", href: '/edit'
end
# --end Scenario: Visit single user profile by registered user

# Scenario: Visiting backend users list
Given /^I am a register user with administrator privileges$/ do
  FactoryGirl.create(:user_role)
  @admin_user = FactoryGirl.create(:admin_user)
  sign_in @admin_user
end

And /^Any users exists$/ do
  @test_user_1, @test_user_2 = FactoryGirl.create(:valid_user), FactoryGirl.create(:valid_user)
end

When /^I visiting backend users path$/ do
  visit backend_users_path
  page.current_url == /backend\/users/
end

Then /^I should see a list of existing users$/ do
  expect(page).to have_content "Список зарегистрированных в системе пользователей:"
  expect(page).to have_link "Создать нового пользователя", href: new_user_registration_path
  expect(page).to have_content @test_user_1.name
  expect(page).to have_content @test_user_2.name
end

And /^I should see manage user controls$/ do
  expect(page).to have_link "Просмотр", href: backend_user_path(@test_user_1)
  expect(page).to have_link "Просмотр", href: backend_user_path(@test_user_2)
  expect(page).to have_link "Удалить"
end
# --end Scenario: Visiting backend users list

# Scenario: Visiting single user page
And /^User (.+) exists$/ do |username|
  @new_user = FactoryGirl.create(:valid_user, name: username, profile: FactoryGirl.build(:profile))
  expect{User.find_by_name(username)}.not_to be_nil
end

When /^I visiting backend users path and click on (.+) profile link$/ do |username|
  current_user = User.find_by_name(username)
  visit backend_users_path
  click_link("Просмотр", href: backend_user_path(current_user))
  expect(current_path).to eq backend_user_path(current_user)
end

Then /^I should see a (.+) profile$/ do |username|
  expect(page).to have_content username
  expect(page).to have_content "Основные данные"
  expect(page).to have_content "Профиль"
  expect(page).to have_content "Привилегии"
  expect(page).to have_content "Контакты"
end

And /^I should see user manage controls$/ do
  expect(page).to have_button "Удалить аккаунт"
  expect(page).to have_link "Редактировать профиль"
end
# --end Scenario: Visiting single user page

# Scenario: Visiting single user page which does not exists
And /^(.+) user does not exists$/ do |username|
  expect(User.find_by_name(username)).to be_nil
end

When /^I visiting backend users path and try access to (.+) profile$/ do |username|
  visit backend_user_path(username)
end

Then /^I should see a not found page$/ do
  expect(page).to have_content "The page you were looking for doesn't exist."
end
# --end Scenario: Visiting single user page which does not exists

# Scenario: Edit user profile
And /^Click on edit profile button$/ do
  find_link("Редактировать профиль").click
end

Then /^I should see edit profile form$/ do
  expect(page).to have_text @new_user.name
  within "#edit_user_#{@new_user.id}" do
    expect(page).to have_selector("h3", text: "Дополнительная информация :")
    expect(page).to have_select("user[profile_attributes][country]")
    expect(page).to have_select("user[profile_attributes][birthday(3i)]")
    expect(page).to have_select("user[profile_attributes][birthday(2i)]")
    expect(page).to have_select("user[profile_attributes][birthday(1i)]")
    expect(page).to have_select("user[profile_attributes][birthday(1i)]")
    expect(page).to have_field("user[profile_attributes][gender]", 
                                        type: "radio",
                                        with: "0"
                                        )
    expect(page).to have_field("user[profile_attributes][gender]", 
                                        type: "radio",
                                        with: "1"
                                        )
    expect(page).to have_field("user[profile_attributes][contacts_phone]", type: "text")
    expect(page).to have_field("user[profile_attributes][contacts_skype]", type: "text")
    expect(page).to have_field("user[profile_attributes][contacts_other]", type: "text")
    expect(page).to have_field("user[profile_attributes][contacts_url]", type: "text")
    expect(page).to have_field("user[profile_attributes][dispatch]", 
                                        type: "radio",
                                        with: "true"
                                        )
    expect(page).to have_field("user[profile_attributes][dispatch]", 
                                        type: "radio",
                                        with: "false"
                                        )
    expect(page).to have_button("Обновить данные")
  end
end
# --end Scenario: Edit user profile

# Scenario: Update user profile
When /^I fill in updated information contact phone as (.+) to profile form$/ do |phone|
  visit backend_user_path @new_user
  step "Click on edit profile button"
  step "I should see edit profile form"
  within "#edit_user_#{@new_user.id}" do
    fill_in('user[profile_attributes][contacts_phone]', with: phone)
  end
end

And /^Click on update button$/ do
  click_button "Обновить данные"
end

Then /^I should redirect to index page with success message$/ do
  expect(current_path).to eq backend_users_path
  expect(page).to have_content "Данные пользователя '#{@new_user.name}' обновленны."
end

And /^User contacts phone should be updated by (.+)$/ do |phone|
  expect(User.find(@new_user).contacts_phone).to eq phone
end
# --end Scenario: Update user profile

# Scenario: Delete user profile
When /^I visiting backend users path and click on delete button$/ do
  visit backend_users_path
  click_link("Удалить", href: backend_user_path(@new_user))
end

Then /^I should redirect to index path with success message$/ do
  expect(current_path).to eq backend_users_path
  expect(page).to have_content "Пользователь удален!"
end

And /^User (.+) should be deleted$/ do |user|
  expect(User.find_by_name(user)).to be_nil
end
# --end Scenario: Delete user profile

# Scenario: Edit user privileges
And /^Click on edit privileges button$/ do
  click_link("Изменить привилегии", href: backend_user_privileges_path(@new_user))
end

Then /^I should see edit privileges form$/ do
  within "#edit_user_#{@new_user.id}" do
    expect(page).to have_select("user[role_ids]")
    expect(page).to have_button("Изменить привилегии")
  end
end
# --end Scenario: Edit user privileges


# Scenario: Update user privileges
And /^(.+) role is user$/ do |role|
  FactoryGirl.create(:manager_role)
  expect{User.find(@new_user.id).role? :user}.to be_true
end

When /^I visiting (.+) profile and click on edit privileges button$/ do |username|
  visit backend_user_path @new_user
  click_link("Изменить привилегии", href: backend_user_privileges_path(@new_user))
end

And /^I select (.+) role on edit privileges form and save$/ do |role|
  step "I should see edit privileges form"
  within "#edit_user_#{@new_user.id}" do
    select('manager', :from => 'user[role_ids]')
    click_button "Изменить привилегии"
  end
end

Then /^(.+) role should be manager$/ do |username|
  expect(User.find(@new_user.id).role? :manager).to be_true
end
# --end Scenario: Update user privileges
