class Pulse < ActiveRecord::Base
  belongs_to :user
  has_many :social_accounts, dependent: :destroy
  accepts_nested_attributes_for :social_accounts
end
