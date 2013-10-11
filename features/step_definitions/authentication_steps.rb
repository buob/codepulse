When(/^I sign up$/) do
  visit root_url
  click_on 'Sign in with GitHub'
end

Then(/^I should be let in$/) do
  expect(page).to have_content 'Successfully authenticated from GitHub account'
end

Then(/^I should be able to edit my new pulse$/) do
  expect(page).to have_content 'Editing pulse'
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
