class CreateCustomerSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_subscriptions do |t|
      t.string :customer_subscription_id
      t.references :customer, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.boolean :is_active, default: true
      t.datetime :renews_on

      t.timestamps
    end
    add_index :customer_subscriptions, :customer_subscription_id, unique: true
  end
end
