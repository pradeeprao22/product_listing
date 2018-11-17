class AddPostTypeToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :categories, :string
  end
end
