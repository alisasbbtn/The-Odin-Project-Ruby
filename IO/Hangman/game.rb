require 'yaml'
require_relative 'helper'

class Game
  def initialize(word, attempts_left = 6, guesses = Array.new, word_show = '_' * word.size, hangman_show = Array.new)
    @word = word
    @word_show = word_show
    @attempts = attempts_left
    @guesses = guesses
    @hangman = [' _________      ',
                '|         |     ',
                '|         0     ',
                '|        /|\\\  ',
                '|        / \\\  ',
                '|               ',]
    @hangman_show = hangman_show
  end

  def process
    while @attempts > 0
      clear_screen
      puts "You have #{@attempts} attempts left."
      show_word

      puts 'Do your guess. Enter the letter (a-z) or ~ to open menu.'

      guess = check_answer {|answer| if (/[a-z]/ =~ answer.downcase || answer == '~') && answer.size == 1
                                       if @guesses.include? answer
                                         puts 'You\'ve already tried it!'
                                         false
                                       else
                                         true
                                       end
                                     else
                                       puts 'Wrong input. Try again.'
                                       false
                                     end }
      if guess == '~'
        return false
      end

      @guesses << guess

      @word.split('').each_index { |index| @word_show[index] = guess if @word[index] == guess}

      hangman if @word.index(guess.to_s).nil?

      if @word == @word_show
        puts 'You win!'
        break
      end

      puts

    end

    show_word
    puts "You lose. The word was \'#{@word}\'" if @attempts == 0
    sleep 3
    true
  end

  def save_game
    puts 'Enter name of save'
    filename = gets.chomp
    File.open("saves/" + filename + ".save" , 'wb') {|f| f.write(YAML.dump ({
        :word => @word,
        :attempts => @attempts,
        :guesses => @guesses,
        :word_show => @word_show,
        :hangman_show => @hangman_show
    })) }
    puts "Your game was saved as #{filename}"
    sleep 3
  end

  def show_word
    @hangman_show.each { |line| puts line }
    @word_show.split('').each {|symbol| print symbol + ' '}
    puts
    @guesses.each {|letter| print letter + ' ' } unless @guesses.empty?
    puts
  end

  def hangman
    @hangman_show << @hangman[-@attempts]
    @attempts -= 1
  end

end
