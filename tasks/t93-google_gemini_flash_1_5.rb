def encode(message)
  vowels = %w(a e i o u A E I O U)
  message.chars.map do |char|
    swapped_case = char.swapcase
    if vowels.include?(swapped_case)
      index = vowels.index(swapped_case)
      new_char = swapped_case.ord + 2
      new_char = new_char > 'z'.ord ? new_char - 26 : new_char
      new_char = new_char > 'Z'.ord ? new_char - 26 : new_char
      new_char.chr
    else
      swapped_case
    end
  end.join
end
