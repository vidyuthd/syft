module Syft
  class Cart
    attr_reader :cart_items, :total, :adjusted_total

    def initialize(cart_items:[])
      @cart_items = cart_items
      @total = 0
      @adjusted_total = 0
    end

    def add(item:nil)
      return if item.nil?

      existing_cart_item = item(product_code: item.code)
      if existing_cart_item.empty?
        @cart_items << CartItem.new(product: item)
      else
        existing_cart_item.first.quantity += 1
      end
      @total += item.price
      @adjusted_total += item.price
    end

    def adjusted_total=(value)
      @adjusted_total = value
    end

    def item(product_code:)
      @cart_items.select {|cart_item| cart_item.product.code == product_code }
    end

    def item_quantity(product_code:)
      cart_item = item(product_code: product_code).first
      if !cart_item.nil?
        return cart_item.quantity
      end
      0
    end
  end

  class CartItem
    attr_accessor :product, :quantity

    def initialize(product:, quantity:1)
      @product = product
      @quantity = quantity
    end
  end
end