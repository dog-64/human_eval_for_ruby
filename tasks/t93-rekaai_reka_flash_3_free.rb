
def encode(message)
  encoded = []
  message.each_char do |c|
    swapped = c.swapcase
    if %w[a e i o u].include?(swapped.downcase)
      shifted = (swapped.ord + 2).chr
      encoded << shifted
    else
      encoded << swapped
    end
  end
  encoded.join
end

 