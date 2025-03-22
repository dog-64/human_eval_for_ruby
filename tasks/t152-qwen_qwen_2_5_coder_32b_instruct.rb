def compare(game, guess)
  game.zip(guess).map { |g, gu| (g - gu).abs }
end