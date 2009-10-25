require File.dirname(__FILE__) + '/../ant.rb'

#TODO: app code in test, magic away
def coordinate_add(a, b)
  [a[0] + b[0], a[1] + b[1]]
end

module LangtonAnt
  describe "Langton's Ant" do
    before(:each) do
      @god = God.new
    end

    it "should start on a black square" do
      @god.world[0,0].should == :black
    end

    it "should defaut unexplored squares to black" do
      @god.world[99,82].should == :black
    end

    it "should designate one square the 'ant'" do
      god = God.new(Ant.new([0,1]))

      god.ant.position.should == [0,1]
    end

    it "should give the ant an initial direction" do
      [:north, :south, :east, :west].should include @god.ant.direction
    end

    context "on a black square" do
      it "should turn square white" do
        god = God.new(Ant.new([0,0]))
        god.world[0,0]= :black

        god.poll

        god.world[0,0].should == :white
      end

      { :north => :east,
        :east => :south,
        :south => :west,
        :west => :north
      }.each do |start_direction, end_direction|
        context "facing #{start_direction}" do
          it "should turn 90 degrees right" do
            god = God.new(Ant.new([0,0], start_direction))

            god.poll

            god.ant.direction.should == end_direction
          end
        end
      end

      { :north => [1,0],
        :east => [0,1],
        :south => [-1,0],
        :west => [0,-1]
      }.each do |start_direction, end_position|

        context "facing #{start_direction}" do
          it "should turn right and move forward one square" do
            god = God.new(Ant.new([0,0], start_direction))

            god.poll

            god.ant.position.should == end_position
          end
        end
      end

    end

    context "on a white square" do
      it "should turn square black" do
        god = God.new(Ant.new([0,0]))
        god.world[0,0]= :white

        god.poll

        god.world[0,0].should == :black
      end

      { :north => :west,
        :east => :north,
        :south => :east,
        :west => :south
      }.each do |start_direction, end_direction|
        context "facing #{start_direction}" do
          it "should turn 90 degrees left" do
            god = God.new(Ant.new([0,0], start_direction))
            god.world[0,0] = :white

            god.poll

            god.ant.direction.should == end_direction
          end
        end
      end

      { :north => [-1,0],
        :east => [0,-1],
        :south => [1,0],
        :west => [0,1]
      }.each do |start_direction, end_position|
        context "starting at [0,0] and facing #{start_direction}" do
          it "should turn left and move forward one square" do
            god = God.new(Ant.new([0,0], start_direction))
            god.world[0,0]= :white

            god.poll

            god.ant.position.should == end_position
          end
        end

        end_position_from_three_five = coordinate_add([3,5], end_position)
        context "starting at [3,5] and facing #{start_direction}" do
          it "should turn left and move forward one square" do
            god = God.new(Ant.new([3,5], start_direction))
            god.world[3,5]= :white

            god.poll

            god.ant.position.should == end_position_from_three_five
          end
        end
      end

    end

    describe 'leaving a trail' do
      context "when the board is all one color" do
        it "should leave the previous square a different colour to the current square" do
          god = God.new(Ant.new([0,0], :north))

          god.world[0,0]= :black
          god.world[1,0]= :black

          god.poll

          god.world[0,0].should == :white
          god.world[1,0].should == :black
        end
      end
    end

    it "should run lots of polls without any errors" do
      god = God.new(Ant.new([0,0], :black))

      100.times { god.poll }
    end
  end

end
