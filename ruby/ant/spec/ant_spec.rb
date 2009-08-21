require 'ant'

describe Ant do
  
  before(:each) do
    @board =  board = mock("board").as_null_object
  end
  
  it "should register with the board" do
    ant = Ant.new
    
    @board.should_receive(:add_ant).with(ant)
    
    ant.place_on_board(@board)
  end 
  
  it "should sense the colour of the square it is on" do
    ant = Ant.new
    ant.place_on_board(@board)
    
    @board.should_receive(:color).with(ant).and_return(:white)
    
    ant.poll
  end

  describe "turning the ant" do
    before :each do
      @ant = Ant.new
      @ant.place_on_board(@board)
    end
    
    context "white square" do
      it "should turn 90* left" do
        @board.stub!(:color).and_return :white
        
        @board.should_receive(:turn).with(@ant, :left)
        @board.should_not_receive(:turn).with(@ant, :right)
        
        @ant.poll
      end
    end
    
    context "black square" do
      it "should turn 90* right" do
        @board.stub!(:color).and_return :black
        
        @board.should_receive(:turn).with(@ant, :right)
        @board.should_not_receive(:turn).with(@ant, :left)

        @ant.poll
      end
    end
  end

  it "should toggle the colour of the current square" do
    @ant = Ant.new
    @ant.place_on_board(@board)
    
    @board.should_receive(:toggle).with(@ant)
    
    @ant.poll
  end

  it "should toggle the colour of the current square" do
    @ant = Ant.new
    @ant.place_on_board(@board)
    
    @board.should_receive(:move).with(@ant)
    
    @ant.poll
  end
end



describe Board do
  describe "generating an initial board" do
    it "should generate a two dimensional board" do
      board = Board.new
      flat_board = board.raw_board

    end
    
    it "should generate a board with black or white squares" do
      board = Board.new
      raw_board = board.raw_board
      
      raw_board.size.should > 0
      raw_board.flatten.each do | item |
        [:white, :black].should include(item)
      end
    end
  end
  
end
