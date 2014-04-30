class Minimax

  #minimax algorithm modified from http://www.neverstopbuilding.com/minimax

  attr_reader :choice

  def initialize(game)
    @game = game
  end

  def best_move
    minimax(@game)
    @choice
  end

  def minimax(game)
    if game.over?
      if game.wins_for?('O')
        return 1
      elsif game.wins_for?('X')
        return -1
      else
        return 0
      end
    end

    scores = []
    moves = []

    game.board.free_moves.each do |move|
      clone = Game.new(false, game.board, game.player)
      clone.turn!(move)
      scores.push minimax(clone)
      moves.push move
    end

    #maximize for O (ai) player
    if game.player == 'O'
      max_score_index = scores.each_with_index.max[1]
      @choice = moves[max_score_index]
      return scores[max_score_index]
    else
      min_score_index = scores.each_with_index.min[1]
      @choice = moves[min_score_index]
      return scores[min_score_index]
    end
  end
end