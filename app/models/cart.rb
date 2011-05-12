class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy 
  
  def add_product(produit_id)
    current_item = line_items.find_by_product_id(produit_id)
    if current_item
      current_item.quantity += 1 unless current_item.quantity.nil?    
    else
      current_item = line_items.build(:product_id => produit_id)
      current_item.quantity =1 #set quantity 1 when create line items
    end
    current_item  
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
  def total_items
    line_items.sum(:quantity)
  end

end
