require File.dirname(__FILE__) + '/spec_helper'

module Bowling
  describe "bowling" do
    include Rolling

    describe "perfect game" do
      it "should score 300" do
        @game = Game.new
        having_rolled(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10) { @game.score.should == 300 }
      end
    end

    describe "no extra games or special rolls" do
      it "should score 24" do
        @game = Game.new
        having_rolled(1,2,
                      1,3,
                      1,2,
                      1,1,
                      1,1,
                      1,1,
                      1,1,
                      1,1,
                      1,1,
                      1,1) { @game.score.should == 24 }
      end
    end
    
    describe "game with single and double strikes and spairs" do
      it "should score 86" do
        @game = Game.new
        having_rolled(10,
                      2,2,
                      10,
                      10,
                      3,3,
                      1,1,
                      5,5,
                      3,1,
                      1,1,
                      1,1) { @game.score.should ==  (14 + 4 + 23 + 16 + 6 + 2 + 13 + 4 + 2 + 2) }
        
      end
    end

    describe "exceeding game limits" do
      it "should not include rolls in score outside of game limits" do
        @game = Game.new
        having_rolled(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10){@game.score.should == 300}
      end
    end
    
  end
end
