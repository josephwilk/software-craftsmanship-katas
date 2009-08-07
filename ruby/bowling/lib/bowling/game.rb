module Bowling
  class Game

    def initialize(frames = [])
      @frames = frames
    end

    def roll(pins)
      current_frame.pins_down(pins)
    end

    def score
      @frames.reverse.reduce(0) {|score_total, frame| puts frame.score; score_total += frame.score}
    end

    private
    def current_frame
      frame = @frames.last
      if frame.nil? || frame.complete?
        @frames << Frame.new
        @frames.last.next_frame = frame
        frame = @frames.last
      end
      frame
    end
  end
end
