MAX_X = 50
MAX_Y = 50

require 'ant'


class DataModel
  def initialize(red, blue)
    @map = {}
    @red = red
    @blue = blue
  end

  def [](x,y)
    @map["#{x}_#{y}"]
  end

  def []=(x,y,val)
    @map["#{x}_#{y}"] = val
  end

  def flip(x,y)
    debug "#{x} and #{y} == " + self[x,y].inspect
    self[x,y][:state] = !self[x,y][:state]
    a = self[x,y][:state]
    self[x,y][:rect].call(a ? @blue : @red)
  end

  def run
    Thread.new do
      10000.times do
        sleep 0.1
      end
    end.run
  end

end


Shoes.app do
  @map = DataModel.new(red, blue)
  @god = LangtonAnt::God.new
  @god_b = LangtonAnt::God.new
  stack do
    (0..MAX_Y).each do |y|
      (0..MAX_X).each do |x|
        stroke black

        @map[x, y] = {
          :rect => lambda { |color| fill color; rect(:top => 10*y, :left => 10*x, :width => 8, :height => 8, :curve => 2)},
          :state => false
        }
        #@map[x,y][:rect].call(red)
      end
    end
  end

  @god.ant.instance_variable_set("@direction", :south)
  @god_b.ant.instance_variable_set("@direction", :north)
  @god_b.instance_variable_set("@world", @god.instance_variable_get("@world"))
  
  animate(200) do
    # Whatever code needs to be run each time to progress the ant one
    # step...
    @god.poll
    position = @god.ant.position
    centered = [position[0] +  MAX_X / 2, position[1] + MAX_Y / 2]
    @map.flip centered[0], centered[1] # coords of square to flip

  
    
    @god_b.poll
    position = @god_b.ant.position
    centered = [position[0] +  MAX_X / 2, position[1] + (MAX_Y / 2)]
    @map.flip centered[0], centered[1] # coords of square to flip
  end
end
