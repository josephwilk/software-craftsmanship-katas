require File.dirname(__FILE__) + '/../spec_helper'

module Bowling
  describe Game do
    def mock_frame(stubs={})
      @inc ||= 0
      @inc += 1
      mock("Frame #{@inc}", stubs)
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

        it "should record roll with the current frame" do
          frame = mock_frame
          Frame.stub!(:new).and_return(frame.as_null_object)

          frame.should_receive(:pins_down).with(8)

          @game = Game.new
          @game.roll(8)
        end
      end

      describe "after the first roll knocked down 8 pins and the second roll knocked of 1" do
        it "should create a new frame" do
          frame = mock_frame(:complete? => false).as_null_object
          Frame.stub!(:new).and_return(frame)

          Frame.should_receive(:new)

          @game = Game.new
          @game.roll(1)
        end
      end
    end

    describe "#score" do
      it "should get the score from all the games frames" do
        frame1, frame2, frame3 = mock_frame.as_null_object, mock_frame.as_null_object, mock_frame.as_null_object
        frame1.stub!(:complete?).and_return(false, true)
        frame2.stub!(:complete?).and_return(false, true)

        Frame.stub!(:new).and_return(frame1, frame2)

        @game = Game.new
        @game.roll(5)
        @game.roll(2)
        @game.roll(5)
        @game.roll(2)

        frame1.should_receive(:score).and_return(7)
        frame2.should_receive(:score).and_return(7)

        @game.score.should == 14
      end
    end

  end
end
