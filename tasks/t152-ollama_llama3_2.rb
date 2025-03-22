def compare(game, guess)
  result = []
  game.size.times do |i|
    diff = (game[i] - guess[i]).abs
    result << diff
  end
  result
end