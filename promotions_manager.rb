module Syft
  class PromotionsManager
    attr_reader :promotion_rules

    ## a model which stores high level of promotion rules and knows what to do with them and acts as an interaction btn checkout process and promotions
    def initialize(promotion_rules:)
      @promotion_rules = set_promotion_rules(promotion_rules: promotion_rules)
    end

    ## chain of responsibility - the first one will trigger rest in chain, can add and remove to chain dynamically
    def apply_chain(cart)
      if !@promotion_rules.empty?
        @promotion_rules.first.apply(cart: cart)
      end
    end

    ## set of promotion rules which will be applied only if applicable
    def set_promotion_rules(promotion_rules:)
      size = promotion_rules.size
      @promotion_rules = promotion_rules.sort_by {|promotion_rule| promotion_rule.precedence}
      @promotion_rules.each_with_index do |promotion_rule, index|
        if index != size - 1
          promotion_rule.next_rule(rule: @promotion_rules[index+1])
        end
      end
    end
  end
end
