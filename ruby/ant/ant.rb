
class LangtonAnt
  
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
    @color = {'0,0' => :black}
    #@color = {} unless @color@color = :white
    @ant_direction = :north
    @ant = [0,0]
  end
  
  def set_color(x, y, color)
    @color["#{x},#{y}"] = color
  end

  def ant_color=(color)
    set_color @ant[0], @ant[1], color 
  end

  def ant_color
    color  @ant[0], @ant[1]
  end
  
  def color(x, y)
    @color["#{x},#{y}"]
  end
  
  def poll
    ant_color = flip(ant_color)
    if ant_color == :black
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
      delta = [0,-1]
    elsif @ant_direction == :south
      delta = [0,1]
    elsif @ant_direction == :west
      delta = [-1,0]
    else
      delta = [1,0]
    end

    @ant = coordinate_add(delta)
  end

  def coordinate_add(a)
    [a[0] + @ant[0], a[1] + @ant[1]]
  end
  
end



