class AddPostTypeToMicroposts < ActiveRecord::Migration[5.2]

  def change
    add_column :microposts, :categorie_id, :integer
  end

end
