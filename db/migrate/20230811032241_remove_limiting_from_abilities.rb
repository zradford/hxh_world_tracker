class RemoveLimitingFromAbilities < ActiveRecord::Migration[7.0]
  def change
    remove_column :abilities, :is_limiting, :boolean
    add_column :abilities, :is_passive, :boolean
  end
end
