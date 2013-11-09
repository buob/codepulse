class Pulse < ActiveRecord::Base
  belongs_to :user
  delegate :social_accounts, to: :user
end
