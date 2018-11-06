json.extract! product, :id, :title, :sku_id, :date_shipped, :categories, :tags, :images, :pro_price, :created_at, :updated_at
json.url product_url(product, format: :json)
