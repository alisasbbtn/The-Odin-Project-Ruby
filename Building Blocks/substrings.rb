def substrings(text, dictionary)
  word_count = Hash.new(0)
  text.split(/\W+/).each { |word|
    dictionary.each { |substring|
      word_count[substring] += 1 if word.downcase.include? substring
    }

  }

  word_count.sort_by { |word, count| word }.to_h
end