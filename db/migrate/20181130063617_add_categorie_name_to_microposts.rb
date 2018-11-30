class AddCategorieNameToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :categoriename, :string
  end
end
