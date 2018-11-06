require 'test_helper'
class ProductTest < ActiveSupport::TestCase
  def setup

    @product = Product.new(title: "arbit product", sku_id: "123456",
                          date:"2018-10-11", categories:"something", tags: "tag1", images: "http://images.png", pro_price: "22545",
                          user_id: "5")

  end

  test "product should be valid" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.title = ""
    assert_not @product.valid?
  end

  test "title lenght should not be to long" do
    @product.title = ""
    assert_not @product.valid?
  end

end