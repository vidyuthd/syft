module Syft
  class MultipleItemsPromotionRule < PromotionRule
    attr_accessor :product_code, :minimum_quantity, :new_value, :old_value, :quantity
    PRECEDENCE = 0

    ## individual promotion rule
    def initialize(product_code:, minimum_quantity:, new_value:, old_value:)
      @product_code = product_code
      @minimum_quantity = minimum_quantity.to_i
      @new_value = new_value.to_f
      @old_value = old_value.to_f
      @precedence = PRECEDENCE
    end

    def is_applicable?(cart:)
      quantity_in_cart(cart: cart) >= @minimum_quantity
    end

    def quantity_in_cart(cart:)
      cart.item_quantity(product_code: @product_code)
    end

    def create_calculator(cart:)
      @promotion_calculator = MultipleItemsCalculator.new(new_value: @new_value, old_value: @old_value, quantity: quantity_in_cart(cart: cart))
    end
  end
end
