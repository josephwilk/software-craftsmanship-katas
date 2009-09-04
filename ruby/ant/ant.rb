require 'forwardable'

class LangtonAnt  
  extend Forwardable

  def_delegator :@ant, :direction, :ant_direction
  def_delegator :@ant, :direction=, :ant_direction=
  def_delegator :@ant, :position
  
  class Ant
    attr_accessor :direction, :position

    CLOCKWISE = {
      :north => :east,
      :east => :south,
      :south => :west,
      :west => :north
    }

    ANTI_CLOCKWISE = CLOCKWISE.invert
    
    def initialize(cordinates = [0,0], direction = :north)
      @direction = direction
      @position = cordinates
    end

    def turn_left
      @direction = ANTI_CLOCKWISE[@direction]
    end
  
    def turn_right
      @direction = CLOCKWISE[@direction]
    end
  end
  
  attr_accessor :ant
  
  def initialize(ant = Ant.new)
    @ant = ant 
    @color = {}        
    @default_color = :black
  end 
  
  def set_color(x, y, color)
    @color["#{x},#{y}"] = color
  end
  
  def ant_color=(color)
    set_color(@ant.position[0], @ant.position[1], color)
  end
    
  def ant_color
    color(@ant.position[0], @ant.position[1])
  end
  
  def color(x, y)
    @color["#{x},#{y}"] || @default_color
  end
  
  def poll
    self.ant_color = flip(self.ant_color)
    if self.ant_color == :black
      @ant.turn_left
    else
      @ant.turn_right
    end

    move
  end

  private
  def flip(color)
    color == :black ? :white : :black
  end


  def move
    if ant_direction == :north
      delta = [0,-1]
    elsif ant_direction == :south
      delta = [0,1]
    elsif ant_direction == :west
      delta = [-1,0]
    else
      delta = [1,0]
    end

    @ant.position = coordinate_add(delta)
  end

  def coordinate_add(a)
    [a[0] + @ant.position[0], a[1] + @ant.position[1]]
  end
  
end
