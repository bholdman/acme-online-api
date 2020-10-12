class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
  has_secure_token :customer_subscription_id
end
