class CartItemsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @cart_item = current_cart.cart_items.new(product: @product, qty: 1)
  end

  def create
    product = Product.find(params[:cart_item][:product_id])
    quantity = params[:cart_item][:qty].to_i

    @cart_item = current_cart.cart_items.find_or_initialize_by(product_id: product.id)

    if @cart_item.new_record?
      @cart_item.qty = quantity
    else
      @cart_item.qty += quantity
    end

    if @cart_item.save
      redirect_to cart_path(current_cart)
    else
      @product = product
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(current_cart), status: :see_other
  end
end