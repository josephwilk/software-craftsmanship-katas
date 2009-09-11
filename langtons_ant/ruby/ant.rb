module LangtonAnt
  class God
    attr_reader :world, :ant

    def initialize(ant = Ant.new)
      @ant = ant
      @world = World.new
    end

    def poll
      @ant.act_on(@world)
    end
  end

  class World
    def initialize
      @board_colors = {}
      @default_color = :black
    end

    def []=(x,y,color)
      @board_colors["#{x},#{y}"] = color
    end

    def [](x, y)
      @board_colors["#{x},#{y}"] || @default_color
    end
  end

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

    def act_on(world)
      world[*@position] == :black ? turn_right :  turn_left
      world[*@position] = flip(world[*@position])
      move_forward
    end

    private
    def turn_left
      @direction = ANTI_CLOCKWISE[@direction]
    end

    def turn_right
      @direction = CLOCKWISE[@direction]
    end

    def move_forward
      @position = coordinate_add(delta)
    end

    def delta
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

    def flip(color)
      color == :black ? :white : :black
    end
  end
end
