require "test/unit/assertions"
include Test::Unit::Assertions

require_relative "./checkout.rb"
require_relative "./product.rb"
require_relative "./cart.rb"
require_relative "./promotions_manager.rb"
require_relative "./promotion_rule.rb"
require_relative "./promotion_rules/cart_total_promotion_rule.rb"
require_relative "./promotion_rules/multiple_items_promotion_rule.rb"
require_relative "./calculators/percent_calculator.rb"
require_relative "./calculators/multiple_items_calculator.rb"

item1 = Syft::Product.new(code: "1", name: "lavender", price: "9.25")
item2 = Syft::Product.new(code: "2", name: "cuff links", price: "45")
item3 = Syft::Product.new(code: "3", name: "kids t-shirt", price: "19.95")

assert_equal 9.25, item1.price, "match price of item1"
assert_equal "lavender", item1.name, "match name of item1"
assert_equal 45, item2.price, "match price of item2"
assert_equal 19.95, item3.price, "match price of item3"

promotion_rules = []
min_amount_promotion_rule = Syft::CartTotalPromotionRule.new(minimum_amount: "60", value: "10")
multiple_items_promotion_rule = Syft::MultipleItemsPromotionRule.new(product_code: "1", minimum_quantity: 2, new_value: "8.5", old_value: "9.25")
promotion_rules << min_amount_promotion_rule
promotion_rules << multiple_items_promotion_rule
co = Syft::Checkout.new(promotion_rules: promotion_rules)
co.scan(item1)
co.scan(item2)
co.scan(item3)
assert_equal 60, min_amount_promotion_rule.minimum_amount, "min amount for promotion should be 60"
assert_equal 2, multiple_items_promotion_rule.minimum_quantity, "min quantity for promotion should be 2"
assert_equal 66.78, co.total.ceil(2), "for all items 10% should be applied"

promotion_rules = []
multiple_items_promotion_rule = Syft::MultipleItemsPromotionRule.new(product_code: "1", minimum_quantity: 2, new_value: "8.5", old_value: "9.25")
promotion_rules << multiple_items_promotion_rule
co = Syft::Checkout.new(promotion_rules: promotion_rules)
co.scan(item1)
co.scan(item2)
co.scan(item1)
assert_equal 62, co.total.ceil(2), "item 1 and min amount both promotions should apply"

promotion_rules = []
min_amount_promotion_rule = Syft::CartTotalPromotionRule.new(minimum_amount: "60", value: "10")
promotion_rules << min_amount_promotion_rule
promotion_rules << Syft::MultipleItemsPromotionRule.new(product_code: "1", minimum_quantity: 2, new_value: "8.5", old_value: "9.25")
co = Syft::Checkout.new(promotion_rules: promotion_rules)
co.scan(item1)
co.scan(item3)
co.scan(item1)
assert_equal 36.95, co.total, "item 1 and min amount both promotions should apply"


promotion_rules = []
min_amount_promotion_rule = Syft::CartTotalPromotionRule.new(minimum_amount: "60", value: "10")
multiple_items_promotion_rule = Syft::MultipleItemsPromotionRule.new(product_code: "1", minimum_quantity: 2, new_value: "8.5", old_value: "9.25")
promotion_rules << min_amount_promotion_rule
promotion_rules << multiple_items_promotion_rule
co = Syft::Checkout.new(promotion_rules: promotion_rules)
co.scan(item1)
co.scan(item2)
co.scan(item1)
co.scan(item3)
assert_equal 73.76, co.total.ceil(2), "item 1 and min amount both promotions should apply"

promotion_rules = []
min_amount_promotion_rule = Syft::CartTotalPromotionRule.new(minimum_amount: "60", value: "10")
multiple_items_promotion_rule = Syft::MultipleItemsPromotionRule.new(product_code: "2", minimum_quantity: 3, new_value: "40", old_value: "45")
promotion_rules << min_amount_promotion_rule
promotion_rules << multiple_items_promotion_rule
co = Syft::Checkout.new(promotion_rules: promotion_rules)
co.scan(item1)
co.scan(item2)
co.scan(item2)
assert_equal 3, multiple_items_promotion_rule.minimum_quantity, "min quantity for promotion should be 3"
assert_equal 89.33, co.total.ceil(2), "only min amount promotion should apply"