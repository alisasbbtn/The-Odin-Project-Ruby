require_relative 'game'

class Hangman
  def initialize

    @dictionary = File.readlines('5desk.txt').select { |word| word if word.length > 5 && word.length < 12 }

    puts 'Welcome to Hangman!'.upcase
    sleep 1
    main_menu

  end

  def main_menu
    clear_screen

    puts "1. New game\n2. Load game\n3. Exit"
    answer =  check_answer {|answer| /[1-3]/ =~ answer ? true : false }

    case answer
      when "1"
        @game = new_game
      when "2"
        @game = load_game
      else
        confirmation ? exit : main_menu
    end

    @game.process ? main_menu : menu
    exit
  end

  def menu
    clear_screen
    puts "1. Resume\n2. Save game\n3. Load game\n4. Exit"
    answer =  check_answer {|answer| /[1-4]/ =~ answer ? true : false }

    case answer
      when "1"
        nil
      when "2"
        @game.save_game
      when "3"
        confirmation ? @game = load_game : menu
      else
        confirmation ? exit : menu
    end

    @game.process ? main_menu : menu

  end

  def new_game
    @game = Game.new(@dictionary[rand(@dictionary.size-1)][/\w+/].chomp.downcase)
  end

  def load_game
    puts 'Choose which game to load or press 0 to return'

    saves = Dir.entries("saves").select { |filename| /[^\.{1,2}]/ =~ filename }
    saves.sort!.each_with_index { |file, index| puts "#{index.to_i + 1}. #{file}" }

    number_of_saves = saves.size
    answer = check_answer { |answer| /[0-#{number_of_saves + 1}]/ =~ answer ? true : false}

    main_menu if answer == '0'

    filename = saves[answer.to_i - 1].to_s
    data = YAML.load_file("saves/" + filename)
    Game.new(data[:word], data[:attempts], data[:guesses], data[:word_show], data[:hangman_show])
  end

end


hangman = Hangman.new
