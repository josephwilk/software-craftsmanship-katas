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
      it "should score 300" do
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

  end
end
