class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :province_name
      t.string :hst
      t.string :gst
      t.string :pst

      t.timestamps
    end
  end
end
