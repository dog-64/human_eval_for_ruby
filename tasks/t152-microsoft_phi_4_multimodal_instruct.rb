def compare(game, guess)
  raise ArgumentError, 'Входные массивы должны быть одинаковой длины' unless game.length == guess.length
  raise ArgumentError, 'Входные массивы не могут быть пустыми' if game.empty? || guess.empty?
  raise ArgumentError, 'Элементы входных массивов должны быть целыми числами' unless game.all? { |n| n.is_a?(Integer) } && guess.all? { |n| n.is_a?(Integer) }

  game.each_with_index.map { |result, index| (result - guess[index]).abs }
end