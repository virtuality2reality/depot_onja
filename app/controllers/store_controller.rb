class StoreController < ApplicationController
  def index    
    @counter = 1    
    if session[:counter].nil?      
      session[:counter] = @counter      
    else            
      @counter = session[:counter] += 1
    end    
    @products = Product.all    
    @cart = current_cart
  end

end
