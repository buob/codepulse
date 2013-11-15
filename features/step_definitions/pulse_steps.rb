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

Given(/^the pulse has social profiles connected$/) do
  github = SocialProfile.create(name: 'github', url: '')
  facebook = SocialProfile.create(name: 'facebook', url: '')
  dribbble = SocialProfile.create(name: 'dribbble', url: '')
  twitter = SocialProfile.create(name: 'twitter', url: '')
  @current_user.social_accounts.create(social_profile: github, handle: 'samwise')
  @current_user.social_accounts.create(social_profile: facebook, handle: 'gamgee')
  @current_user.social_accounts.create(social_profile: dribbble, handle: 'gamgee')
  @current_user.social_accounts.create(social_profile: twitter, handle: 'gamgee')
end

Then(/^I should see the social profiles$/) do
  expect(page).to have_selector '.socials li', count: 4
end

Given(/^they have some github repos$/) do
end

Then(/^I should see the repos listed$/) do
  expect(page).to have_selector '.project', count: 2
end

Then(/^they should have commit activity$/) do
  # in our stub, the project had 49 commits
  page.find('.project:first-child').click
  expect(page).to have_content '49', visible: false
end
