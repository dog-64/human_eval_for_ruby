def get_row(lst, x)
  coords = []
  lst.each_with_index do |row, i|
    row.each_with_index do |val, j|
      coords << [i, j] if val == x
    end
  end
  coords.sort_by { |a, b| [a, -b] }
end