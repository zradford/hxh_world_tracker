class AddCreatedByToCharacter < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :created_by_user_id, :integer
    add_reference :characters, :in_use_by_user, foreign_key: { to_table: :users }
  end
end
