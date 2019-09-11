module Syft
  class PercentCalculator
    attr_accessor :percent

    def initialize(percent:)
      @percent = percent
    end

    def calculate(total)
      total * (1 -  (@percent/100))
    end
  end
end
