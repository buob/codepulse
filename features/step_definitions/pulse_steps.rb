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

Then(/^I should see a pulse with blips for commit activity$/) do
  # in our stub, the commits are 1, 2, 1 from last to first based on
  # viewWidth of 2000, viewHeight of 208, padding of 5, and interval of 16 (pulses.js.coffee)
  path = page.find('.pulse path')['d']

  expect(path).to have_content 'M1995,104'

  expect(path).to have_content '1979,'
  expect(path).to have_content '1963,'
  expect(path).to have_content '1947,'

  expect(path).not_to have_content '1979,104'
  expect(path).not_to have_content '1963,104'
  expect(path).not_to have_content '1947,104'
end

Then(/^they should have commit activity$/) do
  # one time to scroll it, one time to hover... =|
  2.times { page.find('a.project:first-child').click }
  # in our stub, the project had 49 commits
  expect(page).to have_content '49', visible: false
end
