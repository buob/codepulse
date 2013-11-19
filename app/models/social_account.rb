class SocialAccount < ActiveRecord::Base
  belongs_to :social_profile
  belongs_to :pulse
  includes :social_profile
  delegate :name, :url, :color, to: :social_profile
  default_scope -> { includes(:social_profile).order('social_profiles.display_order') }
end
