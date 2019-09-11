module Syft
  class CartTotalPromotionRule < PromotionRule
    attr_accessor :minimum_amount, :discount_type, :value
    DISCOUNT_TYPE_PERCENT = "percent"
    PRECEDENCE = 1

    ## individual promotions initialization with specific params, each rule has a precedence in the chain
    def initialize(minimum_amount:, value:, discount_type: "percent")
      @minimum_amount = minimum_amount.to_f
      @discount_type = discount_type
      @value = value.to_f
      @precedence = PRECEDENCE
    end

    def is_applicable?(cart:)
      cart.total > minimum_amount
    end

    ## application of rule is delegated to calculator which is a functional piece which
    def create_calculator(cart:)
      @promotion_calculator = PercentCalculator.new(percent: @value)
    end
  end
end