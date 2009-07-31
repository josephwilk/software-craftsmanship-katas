module Bowling
  class Game

    def initialize
      @frames = []
    end

    def roll(score)
      frame = @frames.last
      if @frames.empty? || frame.complete?
        @frames << Frame.new
        frame = @frames.last
      end

      frame.pins_down(8)
    end

    def score
      @frames.reduce(0){|score_total, frame| score_total += frame.score}
    end
  end
end
