
def compare(game, guess)
  game.zip(guess).map { |g, h| (g - h).abs }
end

 