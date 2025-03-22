def compare(game, guess)
  raise ArgumentError, "Arrays must not be empty" if game.empty? || guess.empty?
  raise ArgumentError, "Arrays must have the same length" if game.size != guess.size
  game.zip(guess).map { |result, prediction| (result - prediction).abs }
end