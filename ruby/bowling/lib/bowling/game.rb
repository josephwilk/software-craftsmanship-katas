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
      frame = last_game
      if frame.nil? || frame.complete?
        @frames << Frame.new
        frame.next_frame = last_game unless frame.nil?
        frame = last_game
      end
      frame
    end

    def game_ended?
      (@frames.size == 10 && last_game.complete? && !special_last_game?) ||
      (@frames.size == 12 )
    end

    def special_last_game?
      last_game.strike? || last_game.spair? 
    end

    def last_game
      @frames.last
    end
  end
end
