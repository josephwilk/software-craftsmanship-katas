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
      if first_frame? || active_frame.complete?
        new_frame
      else
        active_frame
      end
    end

    def new_frame
      new_frame = Frame.new
      active_frame.next_frame = new_frame unless first_frame?
      @frames << new_frame
      new_frame          
    end

    def first_frame?
      @frames.empty?
    end
    
    def game_ended?
      (@frames.size == 10 && active_frame.complete? && !special_last_game?) ||
      (@frames.size == 12 )
    end

    def special_last_game?
      active_frame.strike? || active_frame.spair? 
    end

    def active_frame
      @frames.last
    end
  end
end
