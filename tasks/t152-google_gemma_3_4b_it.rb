def compare(game, guess)
  result = []
  game.each_with_index do |match, index|
    diff = match - guess[index]
    result << diff.abs
  end
  result
end
