class Universe

  def initialize(x,y)
    @board = Array.new(x) {Array.new(y){'.'}}
  end

  def live(x,y)
    @board[x][y] = 'x'
  end
  
  def tick
  end

  def to_s
    out = StringIO.new
    @board.each do |x|
      out.puts x.to_s
    end
    out.string
  end
  
end
