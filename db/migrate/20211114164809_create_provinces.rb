class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :province_name
      t.integer :hst
      t.integer :gst
      t.integer :pst

      t.timestamps
    end
  end
end
