def compare(game, guess)
  result = []
  game.each_with_index do |g, i|
    result << (g - guess[i]).abs
  end
  result
end