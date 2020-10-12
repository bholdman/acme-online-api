class User < ApplicationRecord
  
  has_secure_password
  has_secure_token :user_id

  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
