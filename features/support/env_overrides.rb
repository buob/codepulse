include Warden::Test::Helpers
Warden.test_mode!

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  provider: 'github',
  uid: '123545',
  info: { email: 'frodo@bagend.me' },
  extra: { raw_info: { name: 'Frodo Baggins'} },
})
