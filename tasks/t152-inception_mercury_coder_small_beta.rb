def compare(game, guess)
  game.zip(guess).map { |g, g| (g - g).abs }
end