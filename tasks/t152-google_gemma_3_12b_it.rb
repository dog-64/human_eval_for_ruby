def compare(game, guess)
  game.length.times do |i|
    (game[i] - guess[i]).abs
  end.to_a
end
