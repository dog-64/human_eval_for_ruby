def compare(game, guess)
  game.zip(guess).map do |result, guess|
    result - guess.abs
  end
end