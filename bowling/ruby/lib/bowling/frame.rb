module Bowling
  class Frame
    TOTAL_PINS = 10

    attr_accessor :next_frame
    attr_reader :roll_1, :roll_2

    def initialize(roll_1 = nil, roll_2 = nil)
      @roll_1, @roll_2 = roll_1, roll_2
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
      (@roll_1 != TOTAL_PINS) && (@roll_1 + @roll_2 == TOTAL_PINS)
    end

    def score
      if three_strikes_in_a_row?
        30
      elsif two_strikes_followed_by_non_strike?
        20 + @next_frame.next_frame.roll_1
      elsif one_strike_followed_by_non_strike?
        @roll_1 + @next_frame.score
      elsif spair?
        10 + @next_frame.roll_1
      elsif @roll_1 && @roll_2
        @roll_1 + @roll_2
      else
        0
      end
    end

    def three_strikes_in_a_row?
      strike_with_following_frame? && @next_frame.strike_with_following_frame? && @next_frame.next_frame.strike?
    end

    def two_strikes_followed_by_non_strike?
      strike_with_following_frame? && @next_frame.one_strike_followed_by_non_strike?
    end

    def one_strike_followed_by_non_strike?
      strike_with_following_frame? && !@next_frame.strike?
    end
    
    def strike_with_following_frame?
      strike? && @next_frame
    end

  end
end
