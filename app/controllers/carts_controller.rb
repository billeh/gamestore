class CartsController < ApplicationController
before_filter :check_that_user_signed_in 
before_filter :check_that_user_is_administrator, :only => [:index]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, :notice => 'Cart was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

   # POST /carts
  def create
    @cart = Cart.new(params[:cart])
    @cart.user_id = session[:user_id]
    if @cart.save
      session[:cart_id] = @cart.id
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render action: "new"
    end
end

# DELETE /carts/1
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_url
  end

# PUT /carts/1/checkout
  def checkout
    if session[:cart_id].nil? then
      redirect_to root_url
    else
      @cart = Cart.find(session[:cart_id])
      @cart.destroy
      session[:cart_id] = nil
    end 
  end
 end 
