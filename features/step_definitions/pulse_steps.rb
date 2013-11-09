Given(/^a user with a pulse exists$/) do
  @current_user = FactoryGirl.create(:user)
  @pulse = @current_user.pulse
end

Given(/^I'm viewing that pulse$/) do
  visit pulse_path @pulse
end

Then(/^I should see the pulse info$/) do
  expect(page).to have_content @pulse.tagline
end
