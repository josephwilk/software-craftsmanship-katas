require File.dirname(__FILE__) + '/../game_of_life'

describe Cell do

  before(:each) do
    @universe = Universe.new(3,3)
  end
 
  context "empty universe" do
    it "should not show any cell as overpopulated" do   
      @universe.each_cell {|cell| cell.should_not be_overpopulated}
    end
  end

  context "universe full of cells" do
    it "should show center cell as overpopulated" do
      @universe.each_cell {|cell| @universe.create(cell)}
      
      @universe.cell(1, 1).should be_overpopulated
    end
  end
  
  context "cell with no neighbours" do
    it "should not be overpopulated" do
      @universe.create_cell(1,1)

      @universe.cell(1, 1).should_not be_overpopulated
    end
  end

  context "cell with 3 neighbours on edge of the universe" do
    it "should not be overpopulated" do
      @universe.create_cell(0,0)
      @universe.create_cell(0,1)
      @universe.create_cell(1,0)
      @universe.create_cell(1,1)
     
      @universe.cell(0, 0).should_not be_overpopulated
    end
  end 
end
