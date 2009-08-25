
class LangstonAnt
  
  attr_accessor :ant, :ant_direction
  attr_writer :color
  
  CLOCKWISE = {
    :north => :east,
    :east => :south,
    :south => :west,
    :west => :north
  }

  ANTI_CLOCKWISE = CLOCKWISE.invert
  
  def initialize
    @color = :white
    @ant_direction = :north
    @ant = [0,0]
  end

  def board
    []
  end
  
  def set_color(x, y, color)
    @color = color
  end
  
  def color(x, y)
    @color
  end
  
  def poll
    @color = flip(@color)
    if @color == :black
      turn_left
    else
      turn_right
    end

    move
  end

  private
  def flip(color)
    color == :black ? :white : :black
  end

  def turn_left
    @ant_direction = ANTI_CLOCKWISE[@ant_direction]
  end
  
  def turn_right
    @ant_direction = CLOCKWISE[@ant_direction]
  end

  def move
    if @ant_direction == :north
      @ant = [1, 0]
    elsif @ant_direction == :south
      @ant = [1,2]
    elsif @ant_direction == :west
      @ant = [0,1]
    else
      @ant = [@ant[0]-1+2, (@ant[1]+1-1) ]
    end
  end
  
end



