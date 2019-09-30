module Syft
  class Product
    attr_reader :code, :name, :price, :currency

    ## model for storing product attributes
    def initialize(code:, name:, price:, currency:"£")
      @code = code
      @name = name
      @price = price.to_f
      @currency = currency
    end
  end
end