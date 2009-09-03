require File.dirname(__FILE__) + '/../ant.rb'


def coordinate_add(a, b)
  [a[0] + b[0], a[1] + b[1]]
end

describe "Langton's Ant" do
  
  before(:each) do
    @langton_ant = LangtonAnt.new
  end
  
  it "should start on a black square" do
    @langton_ant.color(0,0).should == :black
  end
  
  it "should designate one square the 'ant'" do
    @langton_ant.ant = [0,1]

    @langton_ant.ant.should == [0,1]
  end

  it "should give the ant a direction" do
    [:north, :south, :east, :west].should include @langton_ant.ant_direction
  end
  
  context "on a black square" do
    before :each do
      @langton_ant.set_color(0, 0, :black)
    end
    
    it "should turn square white" do
      @langton_ant.ant = [0,0]
      
      @langton_ant.poll
      
      @langton_ant.color(0,0).should == :white
    end


    {:north => :east, :east => :south, :south => :west, :west => :north}.each do |start_direction, end_direction|
      context "facing #{start_direction}" do
        it "should turn 90 degrees right" do
          @langton_ant.ant_direction = start_direction

          @langton_ant.poll

          @langton_ant.ant_direction.should == end_direction
        end
      end
    end
    
    {:north => [1,0], :east => [0,1], :south => [-1,0], :west => [0,-1]}.each do |start_direction, end_position|
      end_position_from_one_one = coordinate_add([1,1], end_position)
      context "facing #{start_direction}" do
        it "should turn right and move forward one square" do
          @langton_ant.ant = [1,1]
          @langton_ant.ant_direction = start_direction

          @langton_ant.poll

          @langton_ant.ant.should == end_position_from_one_one
        end
      end
    end    
    
  end

  context "on a white square" do
    before(:each) do
      @langton_ant.set_color(0,0, :white)
    end
    
    it "should turn square black" do
      @langton_ant.ant = [0,0]

      @langton_ant.poll

      @langton_ant.color(0,0).should == :black
    end

    {:north => :west, :east => :north, :south => :east, :west => :south}.each do |start_direction, end_direction|
      context "facing #{start_direction}" do
        it "should turn 90 degrees left" do
          @langton_ant.ant_direction = start_direction

          @langton_ant.poll

          @langton_ant.ant_direction.should == end_direction
        end
      end
    end

    {:north => [-1,0], :east => [0,-1], :south => [1,0], :west => [0,1]}.each do |start_direction, end_position|
      end_position_from_one_one = coordinate_add([1,1], end_position)
      context "starting at [1,1] and facing #{start_direction}" do
        it "should turn left and move forward one square" do
          @langton_ant.ant = [1,1]
          @langton_ant.ant_direction = start_direction

          @langton_ant.poll

          @langton_ant.ant.should == end_position_from_one_one
        end
      end

      end_position_from_three_five = coordinate_add([3,5], end_position)
      context "starting at [3,5] and facing #{start_direction}" do
        it "should turn left and move forward one square" do
          @langton_ant.ant = [3,5]
          @langton_ant.ant_direction = start_direction

          @langton_ant.poll

          @langton_ant.ant.should == end_position_from_three_five
        end
      end
    end

  end

  describe 'leaving a trail' do
    context "when the board is all one color" do
      it "should leave the previous square a different colour to the current square" do
        ant = LangtonAnt.new

        ant.set_color(0,0, :black)
        ant.set_color(1,0, :black)
        ant.ant = [0,0]
        ant.ant_direction = :north

        ant.poll

        ant.color(0,0).should == :white
        ant.color(1,0).should == :black
      end
    end
  end
end
