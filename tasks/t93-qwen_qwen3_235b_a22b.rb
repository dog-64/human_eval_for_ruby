def encode(message)
  swapped = message.swapcase
  vowels = {
    'a' => 'c', 'e' => 'g', 'i' => 'k', 'o' => 'q', 'u' => 'w',
    'A' => 'C', 'E' => 'G', 'I' => 'K', 'O' => 'Q', 'U' => 'W'
  }
  swapped.chars.map { |c| vowels[c] || c }.join
end