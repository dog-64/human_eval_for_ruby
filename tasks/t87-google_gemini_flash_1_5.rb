def get_row(lst, x)
  coords = []
  lst.each_with_index do |row, row_index|
    row.each_with_index do |val, col_index|
      if val == x
        coords << [row_index, col_index]
      end
    end
  end
  coords.sort_by! { |row, col| [-row, -col] }
  coords.reverse
end
