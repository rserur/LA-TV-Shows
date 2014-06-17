class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :actor, null: false
      t.text :description
      t.integer :television_show_id, null: false

      t.timestamps
    end

    add_index :characters, [:name, :television_show_id], unique: true
  end
end
