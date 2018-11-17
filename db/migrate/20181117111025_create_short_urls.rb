class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.text :original_url
      t.string :shorts_url
      t.string :sanitize_url

      t.timestamps
    end
  end
end
