## Instructions

## Use rbenv and install 2.6.3 version using
```rbenv install 2.6.3```
```rbenv local 2.6.3```


## Usage
# Refer checkout_test.rb - Sample code
```
item1 = Syft::Product.new(code: "1", name: "lavender", price: "9.25")
item2 = Syft::Product.new(code: "2", name: "cuff links", price: "45")
item3 = Syft::Product.new(code: "3", name: "kids t-shirt", price: "19.95")

promotion_rules = []
promotion_rules << Syft::CartTotalPromotionRule.new(minimum_amount: "60", value: "10")
promotion_rules << Syft::MultipleItemsPromotionRule.new(product_code: "1", minimum_quantity: 2, new_value: "8.5", old_value: "9.25")
co = Syft::Checkout.new(promotion_rules: promotion_rules)
co.scan(item1)
co.scan(item2)
co.scan(item3)
assert_equal 66.78, co.total.ceil(2), "for all items 10% should be applied"
```