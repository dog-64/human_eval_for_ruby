def compare(game, guess)
  raise ArgumentError, "Arrays must be of equal length" unless game.length == guess.length
  raise ArgumentError, "Arrays cannot be empty" if game.empty?
  game.zip(guess).map { |a, b| (a - b).abs }
end
