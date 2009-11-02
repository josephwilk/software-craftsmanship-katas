class Universe
  DEAD = '.'
  ALIVE = 'x'
  
  def initialize(x,y)
    @x_max = x-1
    @y_max = y-1
    @board = Array.new(x) {Array.new(y){DEAD}}
  end
  
  def tick
    each_cell do |cell|
      if cell.underpopulated?
        kill(cell)
      elsif cell.overpopulated?
        kill(cell)
      end
    end
  end

  def create_cell(x, y)
    @board[x][y] = ALIVE
  end

  def create(cell)
    create_cell(cell.x, cell.y)
  end

  def alive?(x,y)
    @board[x][y] == ALIVE
  end
  
  def each_cell
    (0..@x_max).each do |x|
      (0..@y_max).each do |y|
        yield Cell.new(x, y, self)
      end
    end
  end

  def cell(x, y)
    Cell.new(x, y, self)
  end
  
  def to_s
    out = StringIO.new
    @board.each do |x|
      out.puts x.to_s
    end
    out.string
  end

  def valid_cell?(x, y)
    (y >= 0 && x >= 0) && (y <= @y_max && x <= @x_max)
  end
  
  private
  def kill(cell)
    @board[cell.x][cell.y] = DEAD
  end

end

class Cell
  attr_reader :x, :y
  
  def initialize(x, y, universe)
    @x = x
    @y = y
    @universe = universe
  end

  def overpopulated?
    alive_neighbours > 3
  end

  def underpopulated?
    alive_neighbours < 2
  end
 
  private
  def alive_neighbours
    alive_neighbours = 0
    neighbour_cells {|x, y| alive_neighbours+= 1 if @universe.alive?(x, y)}
    alive_neighbours
  end
  
  def neighbour_cells
    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        if !skip_offset?(x_offset, y_offset) 
          neighbour_x = @x + x_offset
          neighbour_y = @y + y_offset
          yield(neighbour_x, neighbour_y) if @universe.valid_cell?(neighbour_x, neighbour_y)
        end
      end
    end
  end
  
  def skip_offset?(x_offset, y_offset)
    (x_offset == 0 && y_offset == 0)
  end
end
