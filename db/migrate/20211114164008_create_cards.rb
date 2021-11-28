class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :level
      t.integer :hp
      t.integer :price
      t.references :rarity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
