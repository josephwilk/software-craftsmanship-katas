require 'forwardable'

class LangtonAnt  
  extend Forwardable

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

    def move
      @position = coordinate_add(move_delta)
    end

    private
    def move_delta
      case @direction
      when :north
        delta = [0,-1]
      when:south
        delta = [0,1]
      when :west
        delta = [-1,0]
      else
        delta = [1,0]
      end
    end
        
    def coordinate_add(a)
      [a[0] + @position[0], a[1] + @position[1]]
    end
  end
  
  attr_reader :ant
  
  def initialize(ant = Ant.new)
    @ant = ant 
    @color = {}        
    @default_color = :black
  end 
  
  def set_color(x_y, color)
    @color["#{x_y[0]},#{x_y[1]}"] = color
  end
  
  def ant_color=(color)
    set_color(@ant.position, color)
  end
    
  def ant_color
    color(@ant.position)
  end
  
  def color(x_y)
    @color["#{x_y[0]},#{x_y[1]}"] || @default_color
  end
  
  def poll
    self.ant_color = flip(self.ant_color)
    if self.ant_color == :black
      @ant.turn_left
    else
      @ant.turn_right
    end
    @ant.move
  end

  private
  def flip(color)
    color == :black ? :white : :black
  end
 
end
