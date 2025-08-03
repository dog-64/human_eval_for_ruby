
def get_row(lst, x)
  result = []
  lst.each_with_index do |row, i|
    row.each_with_index do |elem, j|
      if elem == x
        result << [i, j]
      end
    end
  end
  result.sort_by { |coord| [coord[0], -coord[1]] }
end