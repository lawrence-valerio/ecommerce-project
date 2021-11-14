class AddGstPstHstToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :hst, :decimal
    add_column :provinces, :pst, :decimal
    add_column :provinces, :gst, :decimal
  end
end
