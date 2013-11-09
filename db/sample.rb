user = User.create!(email: 'emailme@jakebuob.com', password: 'foobar123', password_confirmation: 'foobar123')

user.pulse.update_attributes(tagline: 'engineer --with class')

SocialProfile.all.each do |profile|
  user.social_accounts << SocialAccount.create(social_profile: profile, handle: 'jakebuob')
end
