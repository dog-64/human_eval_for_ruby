def compare(game, guess)
  game.zip(guess).map { |g, gn| (g - gn).abs }
end