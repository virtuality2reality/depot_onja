class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  skip_before_filter :authorize, :only => [:new, :create]

  def index
    #@orders = Order.all
    @orders = Order.paginate :page=>params[:page], :order=>'created_at desc', :per_page=>10 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    @pay_types = PayType.select([:id,:name])
    if @cart.line_items.empty?
      redirect_to store_url, :notice => 'Your  cart is empty'
      return 
    end
  
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, :notice => 'Your  cart is empty'
      return 
    end    
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)    
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        Notifier.order_received(@order).deliver        
        format.html { redirect_to(store_url, :notice => 'Think you for your order.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        @pay_types = PayType.select([:id,:name])
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
