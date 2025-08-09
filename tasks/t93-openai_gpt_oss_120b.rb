def encode(message)
  vowels = %w[a e i o u A E I O U]
  message.each_char.map do |ch|
    swapped = ch.swapcase
    if vowels.include?(swapped)
      (swapped.ord + 2).chr
    else
      swapped
    end
  end.join
end