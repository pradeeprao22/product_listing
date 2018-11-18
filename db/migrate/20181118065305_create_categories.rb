class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :microposts, foreign_key: true

      t.timestamps
    end
    add_index :categories, [:microposts_id, :created_at]
  end
end
