class Universe
  DEAD = '.'
  ALIVE = 'x'
  
  def initialize(x,y)
    @x_max = x-1
    @y_max = y-1
    @board = Array.new(x) {Array.new(y){DEAD}}
  end
  
  def tick
    cell_analysier = CellAnalysier.new(self)

    each_cell do |x, y|
      if cell_analysier.overpopulated?(x, y)
        kill_cell(x, y)
      end
    end
  end

  def create_cell(x,y)
    @board[x][y] = ALIVE
  end

  def alive?(x,y)
    valid_cell?(x,y) && @board[x][y] == ALIVE
  end
  
  def each_cell
    (0..@x_max).each do |x|
      (0..@y_max).each do |y|
        yield(x, y)
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
  
  private

  def kill_cell(x,y)
    @board[x][y] = DEAD
  end
  
  def valid_cell?(x, y)
    (y >= 0 && x >= 0) && (y <= @y_max && x <= @x_max)
  end
end

class CellAnalysier
  def initialize(universe)
    @universe = universe
  end

  def overpopulated?(x, y)
    neighbours(x, y) > 3
  end
  
  private
  def neighbours(x, y)
    neighbours = 0
    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        unless skip_offset?(x_offset, y_offset)
          neighbour_x = x+x_offset
          neighbour_y = y+y_offset

          neighbours += 1 if @universe.alive?(neighbour_x, neighbour_y)
        end
      end
    end
    neighbours
  end
  
  def skip_offset?(x_offset, y_offset)
    (x_offset == 0 && y_offset == 0)
  end 
end
