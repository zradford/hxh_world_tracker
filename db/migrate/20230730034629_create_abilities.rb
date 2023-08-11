class CreateAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :abilities do |t|
      t.string :name, null: false
      t.string :uses
      t.string :qualifier
      t.string :condition
      t.text :effect, null: false
      t.boolean :is_limiting, default: false

      t.timestamps
    end
  end
end
