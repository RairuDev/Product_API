class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.bigint :category_id, null: false
      t.string :name, null: false
      t.index :name, unique: true
      t.text :description, null: false
      t.timestamps
    end
  end
end
