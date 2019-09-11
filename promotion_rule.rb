module Syft
  class PromotionRule
    attr_accessor :promotion_calculator, :precedence, :next_rule

    def next_rule(rule:)
      @next_rule = rule
    end

    ## an abstract method which will be overriden by respective subclasses
    def is_applicable?(cart:)
    end

    ## each promotion rule needs to figure out if it can be applied or not and delegate to next once its done
    def apply(cart:)
      if !is_applicable?(cart: cart)
        return apply_next_rule(cart: cart)
      end

      @promotion_calculator = self.create_calculator(cart: cart)
      cart.adjusted_total = @promotion_calculator.calculate(cart.adjusted_total)
      apply_next_rule(cart: cart)
    end

    def apply_next_rule(cart:)
      if @next_rule && @next_rule.is_applicable?(cart: cart)
        @next_rule.apply(cart: cart)
      end
    end
  end
end
