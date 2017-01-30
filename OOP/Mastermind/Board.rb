require_relative 'Colorization'

class Board
  attr_reader :board
  def initialize(attempts)
    @board = Array.new
    attempts.times { @board << Row.new }
  end

  def show
    @board.each_index { |index|
      @board[index].show
      print " #{index + 1}"
      puts }
  end

  def fill(row, guess, key)
    @board[row].guess.each_index { |index| @board[row].guess[index] = guess[index].peg }
    key.shuffle!.each_index { |index| @board[row].key[index] = key[index].peg }
  end

  def clear
    @board.clear
    @board = Board.new(12).board
  end
end

class Row
  attr_accessor :guess, :key

  def initialize
    @guess = Array.new(4, 'O')
    @key = Array.new(4, 'o')
  end

  def show
    print @guess.join(' ') + '|' + @key.join('') + '|'
  end
end

class Peg
  attr_reader :peg, :color

  def initialize(symbol, color)
    @peg = symbol.send color.to_sym
    @color = color.to_s
  end

  def self.create_color_peg(color = rand(5))
    symbol = '@'
    return Peg.new(symbol, color.to_sym) if color.is_a?(Symbol)
    case color
      when 1
        Peg.new(symbol, :red)
      when 2
        Peg.new(symbol, :light_blue)
      when 3
        Peg.new(symbol, :green)
      when 4
        Peg.new(symbol, :yellow)
      when 5
        Peg.new(symbol, :blue)
      when 0
        Peg.new(symbol, :pink)
      else
        nil
    end
  end

  def self.create_key_peg(color)
    return Peg.new('•', color.to_sym)
  end
end
