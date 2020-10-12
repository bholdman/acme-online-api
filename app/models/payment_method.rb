class PaymentMethod < ApplicationRecord
  belongs_to :customer
  has_secure_token :payment_method_id
end
