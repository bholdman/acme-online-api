class Subscription < ApplicationRecord
  has_secure_token :subscription_id

  # Make sure we have name, price and term for a subscription
  validates :subscription_name, presence: true
  validates :subscription_price, presence: true
  validates :subscription_term, presence: true

  enum subscription_term: [:day, :week, :month, :year]
end
