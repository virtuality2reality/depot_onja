class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  
  def total_price
    product.price * quantity unless quantity.nil?
  end  
  
  def decrement_item(line_item)
    line_item.quantity -=1 unless line_item.quantity<1
  end

end
