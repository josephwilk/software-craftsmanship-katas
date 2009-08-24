
class LangstonAnt
  
  attr_accessor :ant, :ant_direction
  attr_writer :color
 
  
  def initialize(x, y)
    @color = :white
    @ant_direction = :north
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
    @ant_direction = :west
  end

  def turn_right
    @ant_direction = :east
  end

  def move
    @ant = [0,1]
  end
  
end



