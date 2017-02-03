def check_answer
  answer = ''
  begin
    answer = gets.chomp
  end until yield(answer)
  answer
end

def confirmation
  puts 'Are you sure? All unsaved data will be lost! y/n'
  answer = check_answer {|answer| /y|n/ =~ answer.downcase ? true : false }
  answer == 'y' ? true : false
end

def clear_screen
  Gem.win_platform? ? (system 'cls') : (system 'clear')
end