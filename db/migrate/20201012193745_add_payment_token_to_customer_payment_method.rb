class AddPaymentTokenToCustomerPaymentMethod < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_methods, :payment_token, :string
  end
end
