class CreateRarities < ActiveRecord::Migration[6.1]
  def change
    create_table :rarities do |t|
      t.string :rarity_name

      t.timestamps
    end
  end
end
