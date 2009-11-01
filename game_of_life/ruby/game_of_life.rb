class Universe
  def initialize(x,y)
    @x = x-1
    @y = y-1
    @board = Array.new(x) {Array.new(y){'.'}}
  end

  def live(x,y)
    @board[x][y] = 'x'
  end
  
  def tick
    universe_metrics = UniverseMetrics.new(self)
    
    @board.each_with_index do |x, x_index|
      x.each_with_index do |y, y_index|
        if universe_metrics.neighbours(x_index,y_index) > 3
          @board[x_index][y_index] = '.'
        end
      end
    end
  end

  def to_s
    out = StringIO.new
    @board.each do |x|
      out.puts x.to_s
    end
    out.string
  end

  def live?(x,y)
    valid_cell?(x,y) && @board[x][y] == 'x'
  end

  def size
    return @x, @y
  end
  
  private
  def valid_cell?(x,y)
    (y >= 0 && x >= 0) && (y <= @y && x <= @x)
  end
end

class UniverseMetrics
  def initialize(universe)
    @universe = universe
  end
  
  def neighbours(x,y)
    neighbours = 0
    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        unless skip_offset?(x_offset, y_offset)
          neighbour_x = x+x_offset
          neighbour_y = y+y_offset

          neighbours += 1 if @universe.live?(neighbour_x, neighbour_y)
        end
      end
    end
    neighbours
  end
  
  def skip_offset?(x_offset, y_offset)
    (x_offset == 0 && y_offset == 0)
  end 
end
