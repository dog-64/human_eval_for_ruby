def encode(message)
  vowels = { 'a' => 'c', 'e' => 'g', 'i' => 'k', 'o' => 'q', 'u' => 'w',
             'A' => 'C', 'E' => 'G', 'I' => 'K', 'O' => 'Q', 'U' => 'W' }
  message.chars.map { |char| vowels[char] || char.swapcase }.join
end