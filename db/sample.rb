user = User.find_or_create_by!(email: 'jake@mojotech.com') do |user|
  user.password = 'foobar123'
  user.password_confirmation = 'foobar123'
end

user.pulse.update_attributes(tagline: 'engineer at MojoTech')

SocialProfile.all.each do |profile|
  user.social_accounts << SocialAccount.create(social_profile: profile, handle: 'jakebuob')
end
