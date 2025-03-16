def encode(message)
  alphabet = ('a'..'z').to_a
  message.downcase!
  message.chars.map { |c|
    if alphabet.include?(c)
      (alphabet.index(c) + 2) % 26
    else
      c
    end
  }.join
end