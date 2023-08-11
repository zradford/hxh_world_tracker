class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.integer :level, default: 1
      t.text :motivation
      t.text :specialty
      t.integer :will, default: 0
      t.integer :move, default: 0
      t.integer :fight, default: 0
      t.integer :sense, default: 0
      t.integer :seek, default: 0
      t.text :equipment
      t.integer :plot_armor, default: 7
      t.integer :experience_points, default: 0
      t.integer :strength, default: 10

      t.timestamps
    end
  end
end


