
def compare(game, guess)
  result = []
  (0...game.length).each do |i|
    result << (game[i] - guess[i]).abs
  end
  result
end
