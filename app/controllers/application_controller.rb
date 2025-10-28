class ApplicationController < ActionController::Base
  helper_method :current_cart
  include ActionView::Helpers::NumberHelper

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      
      # セッションIDはあるが、DBからカートが削除された場合に対応
      if cart.nil?
        cart = Cart.create
        session[:cart_id] = cart.id
      end
    else
      # そもそもセッションIDがない（サイトに初めて来た）場合
      cart = Cart.create
      session[:cart_id] = cart.id
    end
    cart
  end
end