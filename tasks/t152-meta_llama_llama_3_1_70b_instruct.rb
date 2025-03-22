def compare(game, guess)
  game.zip(guess).map { |g, gs| (g - gs).abs }
end