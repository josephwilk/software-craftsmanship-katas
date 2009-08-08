module Bowling
  class Game

    def initialize(frames = [])
      @frames = frames
    end

    def roll(pins)
      current_frame.pins_down(pins) unless game_ended?
    end

    def score
      @frames.reverse.reduce(0) {|score_total, frame| score_total += frame.score}
    end

    private
    def current_frame
      frame = @frames.last
      if frame.nil? || frame.complete?
        @frames << Frame.new
        frame.next_frame = @frames.last unless frame.nil?
        frame = @frames.last
      end
      frame
    end

    def game_ended?
      (@frames.size == 10 && @frames.last.complete? && !special_last_game?) ||
      (@frames.size == 12 )
    end

    def special_last_game?
      @frames.last.strike? || @frames.last.spair? 
    end
  end
end
