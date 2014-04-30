class Board

  attr_reader :board

  def initialize(board = nil)
    @board = if board
      Array.new(board.board)
    else
      Array.new(9)
    end
  end

  def get(pos)
    @board[pos]
  end

  def set(pos, player)
    @board[pos] = player
  end

  def free_moves
    moves = Array.new
    @board.each_with_index do |m, i|
      moves.push(i) unless m
    end
    moves
  end

  def to_s
    @board.to_s
  end

  def include?(i)
    @board.include? i
  end
  
end