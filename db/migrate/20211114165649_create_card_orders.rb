class CreateCardOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :card_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
