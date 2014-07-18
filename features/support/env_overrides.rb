require 'cucumber/rspec/doubles'

include Warden::Test::Helpers
Warden.test_mode!

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  provider: 'github',
  uid: '123545',
  auth_token: '23409sdflk234',
  info: { email: 'frodo@bagend.me' },
  extra: { raw_info: { name: 'Frodo Baggins'} },
})

Before do
  load "#{Rails.root}/db/seeds.rb"

  User.any_instance.stub_chain(:github, :repos, :list).and_return(
    [
      OpenStruct.new(
        fork: false,
        full_name: 'buob/codepulse',
        language: 'Ruby',
        name: 'codepulse',
        owner: OpenStruct.new(login: 'buob'),
        private: false,
      ),
      OpenStruct.new(
        fork: false,
        full_name: 'mojotech/something_private',
        language: 'CoffeesScript',
        name: 'something_private',
        owner: OpenStruct.new(login: 'mojotech'),
        private: true,
      )
    ]
  )

  User.any_instance.stub_chain(:github, :repos, :languages).and_return({'Ruby' => 200, 'CoffeesScript' => 100})

  User.any_instance.stub_chain(:github, :repos, :stats, :contributors, :body).and_return(
    [
      OpenStruct.new(
        author: OpenStruct.new(login: 'buob'),
        total: 49,
        weeks: [
          OpenStruct.new(a: 711, c: 10, d: 87, w: 1_379_203_200),
          OpenStruct.new(a: 309, c: 11, d: 19, w: 1_379_808_000),
          OpenStruct.new(a: 128, c: 8, d: 22, w: 1_380_412_800),
          OpenStruct.new(a: 41, c: 4, d: 42, w: 1_381_017_600),
          OpenStruct.new(a: 0, c: 0, d: 0, w: 1_381_622_400),
          OpenStruct.new(a: 0, c: 0, d: 0, w: 1_382_227_200),
          OpenStruct.new(a: 2202, c: 8, d: 107, w: 1_382_832_000),
          OpenStruct.new(a: 306, c: 8, d: 91, w: 1_383_436_800),
          OpenStruct.new(a: 0, c: 0, d: 0, w: 1_384_041_600),
        ]
      )
    ]
  )

  User.any_instance.stub_chain(:github, :repos, :commits, :all).and_return(
    [
      OpenStruct.new(
        commit: OpenStruct.new(
          author: OpenStruct.new(date: Time.now.utc.iso8601.to_s),
        ),
      ),
      OpenStruct.new(
        commit: OpenStruct.new(
          author: OpenStruct.new(date: (Time.now - 1.day).utc.iso8601.to_s),
        ),
      ),
      OpenStruct.new(
        commit: OpenStruct.new(
          author: OpenStruct.new(date: (Time.now - 1.day).utc.iso8601.to_s),
        ),
      ),
      OpenStruct.new(
        commit: OpenStruct.new(
          author: OpenStruct.new(date: (Time.now - 2.days).utc.iso8601.to_s),
        ),
      ),
    ]
  )
end
