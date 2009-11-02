require File.dirname(__FILE__) + '/../game_of_life'

describe CellAnalysier do

  before(:each) do
    @universe = Universe.new(3,3)
  end
 
  context "empty universe" do
    it "should not show any cell as overpopulated" do
      cell_analysier = CellAnalysier.new(@universe)
      
      @universe.each_cell {|x,y| cell_analysier.overpopulated?(x,y).should be_false}
    end
  end

  context "universe full of cells" do
    it "should show center cell as overpopulated" do
      @universe.each_cell {|x,y| @universe.create_cell(x,y)}
      cell_analysier = CellAnalysier.new(@universe)
      
      cell_analysier.overpopulated?(1,1).should be_true
    end
  end
  
  context "cell with no neighbours" do
    it "should not be overpopulated" do
      @universe.create_cell(1,1)

      cell_analysier = CellAnalysier.new(@universe)

      cell_analysier.overpopulated?(1,1).should be_false
    end
  end

  context "cell with 3 neighbours on edge of the universe" do
    it "should not be overpopulated" do
      @universe.create_cell(0,0)
      @universe.create_cell(0,1)
      @universe.create_cell(1,0)
      @universe.create_cell(1,1)

      cell_analysier = CellAnalysier.new(@universe)
      
      cell_analysier.overpopulated?(0,0).should be_false
    end
  end 
end
