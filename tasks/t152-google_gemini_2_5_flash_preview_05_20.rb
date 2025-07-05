def compare(game, guess)
  game.zip(guess).map { |g, s| (g - s).abs }
end