def compare(game, guess)
  raise ArgumentError, "Input arrays must be of equal length" unless game.length == guess.length
  raise ArgumentError, "Input arrays cannot be empty" if game.empty? || guess.empty?
  raise ArgumentError, "Input arrays must contain only integers" unless game.all? { |e| e.is_a?(Integer) } && guess.all? { |e| e.is_a?(Integer) }

  result = []
  game.each_with_index do |game_result, index|
    guess_result = guess[index]
    if game_result == guess_result
      result << 0
    else
      result << (guess_result - game_result).abs
    end
  end
  result
end