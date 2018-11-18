class AddPostTypeToMicroposts < ActiveRecord::Migration[5.2]

  def change
    add_column :microposts, :categories_id, :integer
  end

end
