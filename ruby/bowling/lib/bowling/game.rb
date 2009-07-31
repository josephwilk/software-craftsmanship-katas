module Bowling
  class Game

    def initialize(frames = [])
      @frames = frames
    end

    def roll(pins)
      current_frame.pins_down(pins)
    end

    def score
      previous_frame = @frames[-1]
      @frames.reverse.reduce(0) do |score_total, frame|
        if frame.strike?
          score_total += frame.score + previous_frame.score
        elsif frame.spair?
          score_total += frame.score + previous_frame.first_roll
        else
          score_total += frame.score
        end
        previous_frame = frame
        score_total
      end
    end

    private
    def current_frame
      frame = @frames.last
      if frame.nil? || frame.complete?
        @frames << Frame.new
        frame = @frames.last
      end
      frame
    end
  end
end
