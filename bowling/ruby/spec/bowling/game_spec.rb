require File.dirname(__FILE__) + '/../spec_helper'

module Bowling

  describe Game do
    include Rolling
    def mock_frame(stubs={})
      @inc ||= 0
      @inc += 1
      mock("Frame #{@inc}", {:pins_down => nil}.merge(stubs))
    end

    def mock_normal_frame(roll_1, roll_2)
      frame = mock_frame(:score => roll_1 + roll_2,
                         :strike? => false,
                         :spair? => false,
                         :first_roll => roll_1).as_null_object
      frame.stub!(:complete?).and_return(true)
      frame
    end

    def mock_strike_frame
      frame = mock_frame(:score => 10, :strike? => true).as_null_object
      frame.stub!(:complete?).and_return(true)
      frame
    end

    def mock_spair_frame(roll_1, roll_2)
      frame = mock_frame(:score => 10, :strike? => false, :spair? => true).as_null_object
      frame.stub!(:complete?).and_return(true)
      frame
    end
  
    describe "#roll" do
      describe "first roll of the game" do
        it "should create the first Frame" do
          frame = mock_frame(:complete? => false).as_null_object
          Frame.should_receive(:new).and_return(frame)

          @game = Game.new
          @game.roll(1)
        end

        it "should record rolls with the current frame" do
          frame = mock_frame
          Frame.stub!(:new).and_return(frame.as_null_object)

          frame.should_receive(:pins_down).with(3)
          frame.should_receive(:pins_down).with(4)

          @game = Game.new
          @game.roll(3)
          @game.roll(4)
        end
      end

      describe "after the first roll knocked down 8 pins" do
        it "should create a new frame after second roll" do
          frame = mock_frame(:complete? => false).as_null_object
          Frame.stub!(:new).and_return(frame)

          Frame.should_receive(:new)

          @game = Game.new
          @game.roll(1)
        end
      end

      describe "ending game without any extra games" do
        it "should not create a new frame after last roll" do
          @game = Game.new([mock_normal_frame(1,2)]*10)

          Frame.should_not_receive(:new)
        
          @game.roll(3)
        end
      end

      describe "ending game in a strike" do
        it "should create a new 11th frame" do
          @game = Game.new([mock_strike_frame]*10)
        
          Frame.should_receive(:new).and_return(mock_strike_frame)
        
          @game.roll(1)
        end
      end    
    end

    describe "#score" do
      it "should get the score from all the game's frames" do
        frame1 = mock_normal_frame(5,2)
        frame2 = mock_normal_frame(5,2)

        @game = Game.new [frame1, frame2]

        frame1.should_receive(:score).and_return(7)
        frame2.should_receive(:score).and_return(7)

        @game.score.should == 14
      end
    end

  end
end
