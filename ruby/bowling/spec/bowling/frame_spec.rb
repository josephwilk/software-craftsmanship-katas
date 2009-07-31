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
  end
end
