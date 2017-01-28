module TicTacToe

  class Board
    attr_reader :board

    def initialize
      @cell = ' '
      @board = Array.new(3)  { Array.new(3, @cell) }
    end

    public
    def show
      puts '  ' + (0..2).to_a.join('')
      @board.each_index { |i|
        print "#{i}|"
        @board[i].each_index { |j| print @board[i][j] }
        puts '|' }
      puts
    end

    def full?
      @board.all? { |row| row.all? { |cell| cell != @cell }  }
    end

    def check(symbol, i, j)

      if board[i][0] == symbol.to_s
        return true if win?(@board[i])
      elsif board[0][j] == symbol.to_s
        set = []
        @board[i].each_index { |k| set << @board[k][j] } #check column
        return true if win?(set)
      end

      if @board[1][1] == symbol.to_s
        set = []
        @board.each_index { |k| set << @board[k][k] } #check diagonal
        return true if win?(set)

        set.clear
        set = [board[0][-1], board[1][1], board[-1][0]] #check diagonal
        return true if win?(set)

      end

      false
    end

    def available?(i, j)
      (i.to_i >= 0 && i.to_i < 3) && (j.to_i >= 0 && j.to_i < 3) && @board[i.to_i][j.to_i] == @cell
    end

    def draw(i, j, symbol)
      @board[i][j] = symbol
    end

    def clear
      @board.each_index { |i|
        @board[i].each_index { |j| @board[i][j] = @cell } }
    end

    private
    def win?(set)
      set.all? { |cell| cell != @cell && cell == set[0]}
    end

  end

  class Player
    attr_accessor :symbol
    attr_accessor :name

    def initialize(symbol, name)
      @symbol = symbol
      @name = name
    end

    def self.create

    end

  end

  class Game
    def initialize
      @board = Board.new

      puts 'Player1 for X, enter your name!'
      player_1_name = gets.chomp
      puts 'Player2 for O, enter your name!'
      player_2_name = gets.chomp

      @players = [Player.new('X', player_1_name), Player.new('O', player_2_name)]
      greeting
      @board.show
    end

    def process

      until @board.full?
        win = false
        @players.each { |player|

          puts "Your turn, #{player.name}! Enter the row and the column:"
          check = false
          i = 0
          j = 0

          until check
            i = gets
            j = gets
            if @board.available?(i.to_i, j.to_i)
              check = true
              break
            end
            puts 'Wrong input! Try again!'
          end

          @board.draw(i.to_i, j.to_i, player.symbol)
          @board.show

          break if @board.full?

          win = @board.check(player.symbol, i.to_i, j.to_i)
          if win
            puts "#{player.name} wins!"
            if player.symbol == 'O'
              @players[0].symbol, @players[1].symbol = @players[1].symbol, @players[0].symbol
              @players.reverse!
            end
            break
          end
        }

        break if win

      end

      puts 'End of game! Again? Y/N'

      check = false
      until check
        answer = gets.chomp
        if answer.downcase == 'y'
          check = true
          @board.clear
          @board.show
          process
        elsif answer.downcase == 'n'
          check = true
        else
          puts 'Wrong input. Try again.'
        end
      end
      exit
    end

    private
    def greeting
      puts 'Welcome to Tic Tac Toe!'
      puts "Nice to meet you, #{@players[0].name} and #{@players[-1].name}! Let's the game begin!"
    end
  end
end


game = TicTacToe::Game.new
game.process

