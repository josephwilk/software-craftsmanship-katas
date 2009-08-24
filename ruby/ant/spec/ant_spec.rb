require File.dirname(__FILE__) + '/../ant.rb'


describe "Langton's Ant" do
  
  before(:each) do
    @langton_ant = LangstonAnt.new(1,2)
  end
  
  it "should create a board with black or white squares" do
    [:black, :white].should include @langton_ant.color(0,0)
    [:black, :white].should include @langton_ant.color(0,1)
  end
  
  it "should designate one square the 'ant'" do
    @langton_ant.ant = [0,1]

    @langton_ant.ant.should == [0,1]
  end

  it "should give the ant a direction" do
    [:north, :south, :east, :west].should include @langton_ant.ant_direction
  end
  
  context "ant is on a black square" do
    before :each do
      @langton_ant.ant = [0,0]
    end
    
    it "should turn square white" do
      @langton_ant.set_color(0, 0, :black)

      @langton_ant.poll

      @langton_ant.color(0,0).should == :white
    end

    it "should turn 90 degrees right" do
      @langton_ant.set_color(0, 0, :black)
      @langton_ant.ant_direction = :north

      @langton_ant.poll

      @langton_ant.ant_direction.should == :east
    end
  end

  context "ant is on a white square" do
    it "should turn square black" do
      @langton_ant.set_color(0,0, :white)
      @langton_ant.ant = [0,0]

      @langton_ant.poll

      @langton_ant.color(0,0).should == :black
    end
    
    context "facing north" do  
      it "should turn 90 degrees left" do
        @langton_ant.set_color(0, 0, :white)
        @langton_ant.ant_direction = :north

        @langton_ant.poll

        @langton_ant.ant_direction.should == :west
      end

      it "shouid move west one square" do
        @langton_ant.set_color(0, 0, :white)
        @langton_ant.ant = [1,1]
        @langton_ant.ant_direction = :north

        @langton_ant.poll

        @langton_ant.ant.should == [0, 1]
      end
    end    
  end

  
end
