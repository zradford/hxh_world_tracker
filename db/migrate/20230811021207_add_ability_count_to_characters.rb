class AddAbilityCountToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :ability_count, :integer, default: 4
  end
end
