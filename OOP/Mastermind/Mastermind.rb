require_relative 'Board'

class Game
  attr_reader :code

  def initialize
    @attempts = 12
    @board = Board.new(@attempts)

    @pegs = Array.new
    (0..5).to_a.each { |color| @pegs << Peg.create_color_peg(color) }

    code_colors = (0..5).to_a.shuffle![0..3]
    @code = Array.new
    code_colors.each { |color| @code << Peg.create_color_peg(color) }

    
    puts 'Welcome to Mastermind!'.upcase
    puts
    sleep 1
  end

  def process
    for attempt in (0...@attempts)
      show

      puts 'Do your guess. Pick four colors by name'
      guess = Array.new
      4.times {
        check = false
        until check
          color = gets.chomp
          if @pegs.map { |peg| peg.color }.include?(color) && !guess.map { |peg| peg.color }.include?(color)
            guess << Peg.create_color_peg(color.to_sym)
            check = true
          else
            puts 'Wrong input. Try again'
          end
        end
      }

      key = Array.new
      guess.each_index { |index|
        if guess[index].color == @code[index].color
          key << Peg.create_key_peg(:black)
        elsif @code.map { |peg| peg.color }.include?(guess[index].color)
          key << Peg.create_key_peg(:white)
        end
      }
      if key.size != 4
        4-key.size.times { key << nil }
      end

      @board.fill(attempt, guess, key.shuffle!)

      if key.map {|key| !key.nil? } == 4 && key.all? { |peg| peg.color == 'black' }
        show
        puts 'Wow, you guessed it!'
        break
      end

    end

    show
    puts 'End of game! Again?'
    check = false
    until check
      answer = gets.chomp
      if answer.downcase == 'y'
        check = true
        @board.clear
        process
      elsif answer.downcase == 'n'
        check = true
      else
        puts 'Wrong input. Try again.'
      end
    end
  end

  def show
    Gem.win_platform? ? (system 'cls') : (system 'clear')

    @board.show
    puts
    @pegs.each { |peg| print peg.peg + ' ' + (peg.color.send peg.color.to_sym).to_s + ' | ' }
    puts
  end

end

game = Game.new
game.process

