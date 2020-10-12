class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.string :payment_method_id
      t.references :customer, null: false, foreign_key: true
      t.datetime :payment_expires_at

      t.timestamps
    end
    add_index :payment_methods, :payment_method_id, unique: true
  end
end
