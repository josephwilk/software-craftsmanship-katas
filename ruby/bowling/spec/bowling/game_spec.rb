require File.dirname(__FILE__) + '/../spec_helper'

module Bowling
  describe Game do
    def mock_frame(stubs={})
      @inc ||= 0
      @inc += 1
      mock("Frame #{@inc}", stubs)
    end

    def mock_normal_frame(roll_1, roll_2)
      frame = mock_frame(:score => roll_1 + roll_2,
                         :strike? => false,
                         :spair? => false,
                         :first_roll => roll_1).as_null_object
      frame.stub!(:complete?).and_return(false, true)
      frame
    end

    def mock_strike_frame
      frame = mock_frame(:score => 10, :strike? => true).as_null_object
      frame.stub!(:complete?).and_return(true)
      frame
    end

    def mock_spair_frame(roll_1, roll_2)
      frame = mock_frame(:score => 10, :strike? => false, :spair? => true).as_null_object
      frame.stub!(:complete?).and_return(false, true)
      frame
    end

    describe "ending game" do
      it "should not create a new frame after last roll" do
        @game = Game.new
      end
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
    end

    describe "#score" do
      context "strike(10), followed by 3,4 pins" do
        it "should calculate a score of (10 + 7) + 7" do
          frame1 = mock_strike_frame
          frame2 = mock_normal_frame(3,4)

          @game = Game.new [frame1, frame2]

          @game.score.should == 24
        end
      end

      context "spair(5,5), followed by 3,4 pins" do
        it "should calculate a score of (10 + 3) + 7" do
          frame1 = mock_spair_frame(5,5)
          frame2 = mock_normal_frame(3,4)

          @game = Game.new [frame1, frame2]

          @game.score.should == 20
        end
      end

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
