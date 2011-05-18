class StoreController < ApplicationController
  skip_before_filter :authorize, :only => [:index]
  def index    
    @counter = 1    
    if session[:counter].nil?      
      session[:counter] = @counter      
    else            
      @counter = session[:counter] += 1
    end    
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else      
      @products = Product.all    
      @cart = current_cart
    end
  end

end
