class Customer < ApplicationRecord
  has_secure_token :customer_id

  # Validate all of the standard customer fields as well as address since we have to know where to ship
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

end
