class Ant
  def poll
    color = @board.color(self)
    if color == :white
      @board.turn self, :left
    else
      @board.turn self, :right
    end

    @board.toggle self

    @board.move self
  end

  def place_on_board(board)
    @board = board
    board.add_ant(self)
  end
  
end


class Board
  def add_ant(ant)
  end

  def locate_ant(ant)
  end

  def raw_board
    [:black]
  end
end
