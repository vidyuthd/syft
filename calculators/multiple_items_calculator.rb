module Syft
  class MultipleItemsCalculator
    attr_reader :new_value, :old_value, :quantity

    def initialize(new_value:, old_value:, quantity:)
      @new_value = new_value
      @old_value = old_value
      @quantity = quantity
    end

    def calculate(total)
      total - (@quantity * @old_value) + (@quantity * @new_value)
    end
  end
end