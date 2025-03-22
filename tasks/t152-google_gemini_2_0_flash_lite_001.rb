def compare(game, guess)
  game.zip(guess).map { |g, p| (g - p).abs }
end