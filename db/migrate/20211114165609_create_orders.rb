class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.decimal :order_total
      t.decimal :hst
      t.decimal :gst
      t.decimal :pst
      t.string :stripe_id

      t.timestamps
    end
  end
end
