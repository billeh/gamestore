class ItemsController < ApplicationController
  before_filter :check_that_user_signed_in 
  before_filter :check_that_user_is_administrator, :except => [:create, :destroy]


  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, :notice => 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

 # POST /items
  def create
    @item = Item.new(params[:item])
    @item.cart_id = session[:cart_id]
    if @item.save
      redirect_to cart_url(Cart.find(session[:cart_id]))
    else
      redirect_to cart_url(Cart.find(session[:cart_id])), :alert => 'The quantity must be positive'
    end 
  end

  # DELETE /items/1
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to cart_url(Cart.find(session[:cart_id]))
  end
 end 