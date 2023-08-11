class AddAbilitiesToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_reference :abilities, :character, foreign_key: true
  end
end
