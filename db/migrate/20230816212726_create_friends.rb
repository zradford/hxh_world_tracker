class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.string :name, null: false
      t.text :appearance
      t.text :notes
      t.string :occupied_with
      t.string :location
      t.text :equipment
      t.text :nen_notes
      t.integer :bonus, default: 0
      t.boolean :available

      t.timestamps
    end
  end
end
