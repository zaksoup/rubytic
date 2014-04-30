require 'curses'
require './board'
require './game'
require './minimax'
include Curses


class Rubytic

  def main
    # game = Game.new
    # reprint_board(game)

    #TODO break out new games into function

    @pos = 0
    @player = 'X'
    @ai = ARGV.include? "-c"
    cbreak
    game = Game.new
    go_to(@pos)
    reprint_board(game)
    print_message("q to quit, space to go, arrows to move")
    minimax = Minimax.new(game) if @ai

    while true
      #clear
      #print_message(Minimax.new(game).best_move.to_s)
      #debugging
      #print_message(game.board.to_s)
      if @won
        c = getch
        if c == ' '
          game = Game.new
          minimax = Minimax.new(game) if @ai
          @won = false
          @pos = 0
          @player = 'X'
          curs_set(1)
          clear
          print_message("q to quit, space to go, arrows to move")
        end
      end

      unless @won
        reprint_board(game)
        c = getch
        case c
        when ' '
          next unless game.valid?(@pos)
          game.turn!(@pos)
          if game.over?
            game_over(game)
          end
          game.turn!(minimax.best_move) if @ai && !@won
          if game.over?
            game_over(game)
          end
        when 'q'
          return
        when Key::DOWN
          move_down
        when Key::UP
          move_up
        when Key::RIGHT
          move_right
        when Key::LEFT
          move_left
        end
      end

    end

  end

  def game_over(game)
    @won = true
    clear
    setpos(0,0)
    curs_set(0)
    if game.cat?
      addstr("Cat's Game! Press space to play again")
    else
      addstr("#{game.player} Won! Press space to play again")
    end
  end

  def reprint_board(game)
    setpos(0,0)
    attron(A_UNDERLINE)
    addstr("#{game.board.get(0) || ' '}|#{game.board.get(1) || ' '}|#{game.board.get(2) || ' '}")
    setpos(1,0)
    addstr("#{game.board.get(3) || ' '}|#{game.board.get(4) || ' '}|#{game.board.get(5) || ' '}")
    attroff(A_UNDERLINE)
    setpos(2,0)
    addstr("#{game.board.get(6) || ' '}|#{game.board.get(7) || ' '}|#{game.board.get(8) || ' '}")
    go_to(@pos)
  end

  def switch_player!
    if @player == 'X'
      @player = 'O'
    else
      @player = 'X'
    end
  end

  def go_to(i)
    setpos((i/3),(i%3)*2)
  end

  def move_down
    @pos = @pos + 3 < 9 ? @pos + 3: @pos
    go_to(@pos)
  end

  def move_up
    @pos = @pos -3 >= 0 ? @pos - 3: @pos
    go_to(@pos)
  end

  def move_right
    @pos = @pos + 1 < 9 ? @pos + 1: @pos
    go_to(@pos)
  end

  def move_left
    @pos = @pos -1 >= 0 ? @pos - 1: @pos
    go_to(@pos)
  end

  def print_message(message)
    setpos(4,0)
    addstr(message)
    go_to(@pos)
  end

  def computer_turn
    print_message "computer turn"
  end

end

#A_UNDERLINE
#A_STANDOUT
#attron/attroff
#curs_set
 
init_screen
# curs_set(0) 
noecho
stdscr.keypad(true)
# begin
#   setpos(6, 3)  # column 6, row 3
#   attron(A_UNDERLINE)
#   addstr(Board.new.butt)
#   attroff(A_UNDERLINE)
  
#   getch
# ensure
#   close_screen
# end

Rubytic.new.main
close_screen