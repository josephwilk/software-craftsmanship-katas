require File.dirname(__FILE__) + '/../game_of_life'

describe UniverseMetrics do

  before(:each) do
    @universe = Universe.new(3,3)
  end
 
  context "empty universe" do
    it "should score all neighbours 0" do
      universe_metrics = UniverseMetrics.new(@universe)
      
      @universe.each_cell {|x,y| universe_metrics.neighbours(x,y).should == 0}
    end
  end

  context "universe full of cells" do
    it "should score center cell with neighbours of 8" do
      @universe.each_cell {|x,y| @universe.live(x,y)}
      universe_metrics = UniverseMetrics.new(@universe)
      
      universe_metrics.neighbours(1,1).should == 8
    end
  end
  
  context "cell with no neighbours" do
    it "should score neighbours 0" do
      @universe.live(1,1)

      universe_metrics = UniverseMetrics.new(@universe)

      universe_metrics.neighbours(1,1).should == 0
    end
  end

  context "cell on edge of the universe" do
    it "should score edges of the board as 0" do
      @universe.live(0,1)
      @universe.live(1,0)
      @universe.live(1,1)

      universe_metrics = UniverseMetrics.new(@universe)
      
      universe_metrics.neighbours(0,0).should == 3
    end
  end 
end
