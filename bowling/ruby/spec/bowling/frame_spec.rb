require File.dirname(__FILE__) + '/../spec_helper'

module Bowling
  describe Frame do
    describe "#complete?" do
      context "strike" do
        it "should indictate frame is complete" do
          frame = Frame.new
          frame.pins_down(10)

          frame.should be_complete
        end
      end

      context "normal frame(2,2)" do
        it "should indicate frame is complete" do
          frame = Frame.new
          frame.pins_down(2)
          frame.pins_down(2)

          frame.should be_complete
        end
      end

      context "roll 1 only" do
        it "should show frame is not complete" do
          frame = Frame.new
          frame.pins_down(2)

          frame.should_not be_complete
        end
      end
    end

    describe "#strike?" do
      context "with a strike" do
        it "should indicate frame has a strike" do
          frame = Frame.new
          frame.pins_down(10)

          frame.should be_strike
        end
      end

      context "without a strike" do
        it "should indicate frame does not have a strike" do
          frame = Frame.new
          frame.pins_down(5)
          frame.pins_down(5)

          frame.should_not be_strike
        end
      end
    end

    describe "#spair?" do
      context "roll 5,5" do
        it "should show frame as being a spair" do
          frame = Frame.new(5,5)

          frame.should be_spair
        end
      end

      context "roll 5,2" do
        it "should show frame as not being a spair" do
          frame = Frame.new(5,2)

          frame.should_not be_spair
        end
      end
    end

    describe "#score" do
      context "rolling: 5, 5, 3, 4 pins" do
        it "should score the first frame as (10) + 3" do
          frame_1 = Frame.new(5,5)
          frame_2 = Frame.new(3,4)
          frame_1.next_frame = frame_2

          frame_1.score.should == 13
        end
      end

      context "rolling: 10, 3, 4" do
        it "should calculate first frame score as (10) + 7" do
          frame_1 = Frame.new(10)
          frame_2 = Frame.new(3,4)

          frame_1.next_frame = frame_2

          frame_1.score.should == 17
        end
      end

      context "rolling: 10, 10, 10, 3, 4" do

        before(:each) do
          @frame_1 = Frame.new(10)
          @frame_2 = Frame.new(10)
          @frame_3 = Frame.new(10)
          @frame_4 = Frame.new(3, 4)
          @frame_1.next_frame = @frame_2
          @frame_2.next_frame = @frame_3
          @frame_3.next_frame = @frame_4
        end

        it "should calculate 1st frame score as 30" do
          @frame_1.score.should == 30
        end

        it "should calculate 2nd frame score as 20 + 3" do
          @frame_2.score.should == 23
        end

        it "should calculate 3rd frame score as 0" do
          @frame_3.score.should == 17
        end
      end

      context "rolling: 10, 10, 10" do

        before(:each) do
          @frame_1 = Frame.new(10)
          @frame_2 = Frame.new(10)
          @frame_3 = Frame.new(10)
          @frame_1.next_frame = @frame_2
          @frame_2.next_frame = @frame_3
        end

        it "should calculate 1st frame score as 30" do
          @frame_1.score.should == 30
        end

        it "should calculate 2nd frame score as 0" do
          @frame_2.score.should == 0
        end

        it "should calculate 3rd frame score as 0" do
          @frame_3.score.should == 0
        end
      end
    end
  end
end

