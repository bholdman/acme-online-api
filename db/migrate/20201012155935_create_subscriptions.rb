class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :subscription_id
      t.string :subscription_name
      t.integer :subscription_price
      t.integer :subscription_term

      t.timestamps
    end
    add_index :subscriptions, :subscription_id, unique: true
  end
end
