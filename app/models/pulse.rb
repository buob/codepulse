class Pulse < ActiveRecord::Base
  belongs_to :user
  has_many :social_accounts
end
