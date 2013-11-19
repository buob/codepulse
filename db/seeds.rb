social_profiles = [
  {name: 'facebook', url: 'http://facebook.com/', color: '#43609c', display_order: 2},
  {name: 'dribbble', url: 'http://dribbble.com/', color: '#cb376e', display_order: 3},
  {name: 'twitter', url: 'http://twitter.com/', color: '#00aeed', display_order: 4},
  {name: 'linkedin', url: 'http://linkedin.com/in/', color: '#23639b', display_order: 5},
]

social_profiles.each do |p|
  profile = SocialProfile.find_or_create_by(name: p[:name])
  profile.update_attributes(
    url: p[:url],
    color: p[:color],
    display_order: p[:display_order]
  )
end
