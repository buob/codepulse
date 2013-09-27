When(/^I sign up$/) do
  visit new_user_registration_path
  fill_in 'user_email', with: 'frodo@bagend.me'
  fill_in 'user_password', with: 'the0ner1ng'
  fill_in 'user_password_confirmation', with: 'the0ner1ng'
  click_on 'Sign up'
end

Then(/^I should have a pulse$/) do
  expect(page).to have_content 'Welcome'
end

Then(/^I should be on the edit page$/) do
  expect(page).to have_content 'Editing pulse'
end

Given(/^I have an account$/) do
  @current_user = FactoryGirl.create :user
end

When(/^I sign in$/) do
  visit new_user_session_path
  fill_in 'Email', with: @current_user.email
  fill_in 'Password', with: @current_user.password
  click_on 'Sign in'
end

Given(/^I'm a visitor$/) do
end

Then(/^I should not be able to edit a page$/) do
  pulse = FactoryGirl.create :pulse
  visit edit_pulse_path pulse
  expect(page).to have_content 'Sign in'
end

Then(/^I should be able to view a pulse$/) do
  pulse = FactoryGirl.create :pulse
  visit pulse_path pulse
  expect(page).to_not have_content 'Sign in'
end
