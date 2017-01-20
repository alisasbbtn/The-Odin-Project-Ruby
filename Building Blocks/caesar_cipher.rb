def caesar_cipher text, shift
  encoded_text = ''
  text.split('').each { |symbol|
    if /\W|\d/ === symbol
      encoded_text += symbol
    elsif (symbol.ord + shift).chr > 'Z' && symbol == symbol.upcase
      encoded_text += ('A'.ord + shift - ('Z'.ord - symbol.ord) - 1).chr
    elsif (symbol.ord + shift).chr > 'z' && symbol == symbol.downcase
      encoded_text += ('a'.ord + shift - ('z'.ord - symbol.ord) - 1).chr
    else
      encoded_text += (symbol.ord + shift).chr
    end
  }
  encoded_text
end

def caesar_decipher text, shift
  decoded_text = ''
  text.split('').each { |symbol|
    if /\W/ === symbol
      decoded_text += symbol
    elsif (symbol.ord - shift).chr < 'A' && symbol == symbol.upcase
      decoded_text += ('Z'.ord - shift + (symbol.ord - 'A'.ord) + 1).chr
    elsif (symbol.ord - shift).chr < 'a' && symbol == symbol.downcase
      decoded_text += ('z'.ord - shift + (symbol.ord - 'a'.ord) + 1).chr
    else
      decoded_text += (symbol.ord - shift).chr
    end}
  decoded_text
end