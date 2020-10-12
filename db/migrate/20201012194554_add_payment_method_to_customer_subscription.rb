class AddPaymentMethodToCustomerSubscription < ActiveRecord::Migration[6.0]
  def change
    add_reference :customer_subscriptions, :payment_method, null: false, foreign_key: true
  end
end
