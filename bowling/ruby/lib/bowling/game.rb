module Bowling
  class Game

    def initialize(frames = [])
      @frames = frames
    end

    def roll(pins)
      current_frame.pins_down(pins) unless game_ended?
    end

    def score
      @frames.reduce(0) {|score_total, frame| score_total += frame.score}
    end

    private
    def current_frame
      frame = last_frame
      if frame.nil? || frame.complete?
        @frames << Frame.new
        frame.next_frame = last_frame unless frame.nil?
        frame = last_frame
      end
      frame
    end

    def game_ended?
      (@frames.size == 10 && last_frame.complete? && !special_last_game?) ||
      (@frames.size == 12 )
    end

    def special_last_game?
      last_frame.strike? || last_frame.spair? 
    end

    def last_frame
      @frames.last
    end
  end
end
