module Bowling
  class Frame
    TOTAL_PINS = 10

    def initialize
      @roll_1, @roll_2 = nil, nil
    end

    def pins_down(pins)
      if @roll_1
        @roll_2 = pins
      else
        @roll_1 = pins
      end
    end

    def complete?
      (@roll_1 && @roll_2) || (@roll_1 == TOTAL_PINS)
    end

    def strike?
      @roll_1 == TOTAL_PINS
    end

    def spair?
      (@roll_1 != TOTAL_PINS) && (@roll_1 + @roll_2 != 0)
    end
  end
end
