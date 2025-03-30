
def get_row(lst, x)
  coordinates = []
  lst.each_with_index do |row, row_idx|
    row.each_with_index do |element, col_idx|
      coordinates << [row_idx, col_idx] if element == x
    end
  end
  coordinates.sort_by { |r, c| [r, -c] }
end

 