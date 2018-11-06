class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :sku_id
      t.date :date_shipped
      t.text :categories
      t.text :tags
      t.text :images
      t.integer :pro_price

      t.timestamps
    end
  end
end
