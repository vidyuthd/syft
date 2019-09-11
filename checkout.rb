module Syft
  class Checkout
    attr_accessor :promotions_manager, :cart

    def initialize(promotion_rules:[])
      @cart = Cart.new
      @promotions_manager = PromotionsManager.new(promotion_rules: promotion_rules)
    end

    ## create a cart item and add to cart(update details of cart)
    def scan(item)
      @cart.add(item: item)
    end

    ## check for all promotions and apply(apply on cloned cart, don't want cart to be mutated)
    def total
      cloned_cart = cart.clone
      @promotions_manager.apply_chain(cloned_cart)
      cart.adjusted_total = cloned_cart.adjusted_total
      cart.adjusted_total
    end
  end
end