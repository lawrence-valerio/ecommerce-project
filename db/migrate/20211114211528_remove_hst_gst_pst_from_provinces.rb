class RemoveHstGstPstFromProvinces < ActiveRecord::Migration[6.1]
  def change
    remove_column :provinces, :hst, :string
    remove_column :provinces, :gst, :string
    remove_column :provinces, :pst, :string
  end
end
