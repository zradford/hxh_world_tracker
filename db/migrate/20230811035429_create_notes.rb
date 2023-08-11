class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user
      t.string :title
      t.text :body
      t.boolean :private

      t.timestamps
    end
  end
end
