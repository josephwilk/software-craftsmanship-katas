require 'forwardable'

class LangtonAnt
  extend Forwardable

  class Ant
    attr_reader :direction, :position

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
        [0,-1]
      when:south
        [0,1]
      when :west
        [-1,0]
      else
        [1,0]
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

  def []=(x,y,color)
    @color["#{x},#{y}"] = color
  end

  def [](x, y)
    @color["#{x},#{y}"] || @default_color
  end

  def poll
    self.[]=(@ant.position[0], @ant.position[1], flip(ant_color))
    if ant_color == :black
      @ant.turn_left
    else
      @ant.turn_right
    end
    @ant.move
  end

  private
  def ant_color
    self.[](*@ant.position)
  end

  def flip(color)
    color == :black ? :white : :black
  end

end
