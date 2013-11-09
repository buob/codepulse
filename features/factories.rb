FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "hobbit_#{n}@shirenet.me"}
    password 'gaffers-br3w'
    password_confirmation 'gaffers-br3w'
    pulse
  end

  factory :pulse do
    sequence(:url) {|n| "old_toby_#{n}"}
    tagline 'best-brew --in shire'
  end
end
