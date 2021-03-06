# -*- encoding : utf-8 -*-
class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity
  belongs_to :product
  belongs_to :order
  belongs_to  :cart
  def total_price
    product.price * quantity
  end
end
