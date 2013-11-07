class SocialAccount < ActiveRecord::Base
  belongs_to :social_profile
  belongs_to :user
  includes :social_profile
  delegate :name, :url, to: :social_profile
  default_scope -> { includes(:social_profile).order('social_profiles.display_order') }
end