class Game
  attr_accessor :board
  attr_reader :won

  #should probably move this to rubytic
  attr_reader :player

  def initialize(computer = false, board = nil, player = 'X')
    @board = Board.new(board)
    @player = player
  end

  #this is awful what are you doing, Zak?
  def switch_player!
    return @player = 'X' unless @player == 'X'
    @player = 'O'
  end

  def turn!(pos)
    @board.set(pos, @player)
    switch_player! unless over?
  end

  def valid?(pos)
    @board.free_moves.include? pos
  end

  def wins_for?(player)
    for i in 0..2
      return true if @board.get(i) == @board.get(i+3) &&
                     @board.get(i) == @board.get(i+6) &&
                     @board.get(i) == player
    end
    for i in [0,3,6]
      return true if @board.get(i) == @board.get(i+1) &&
                     @board.get(i) == @board.get(i+2) &&
                     @board.get(i) == player
    end
    return (@board.get(0) == @board.get(4) &&
           @board.get(0) == @board.get(8) &&
           @board.get(0) == player) ||
           (@board.get(6) == @board.get(4) &&
           @board.get(6) == @board.get(2) &&
           @board.get(6) == player)
  end

  def over?
    !@board.include?(nil) || wins_for?('X') || wins_for?('O')
  end

  def cat?
    over? && !wins_for?('X') && !wins_for?('O')
  end

end