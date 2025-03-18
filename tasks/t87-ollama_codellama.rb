
def get_row(lst, x)
  result = []
  lst.each_with_index do |row, i|
    row.each_with_index do |item, j|
      if item == x
        result << [i, j]
      end
    end
  end
  result.sort_by! { |(i, j)| [-i, -j] }
end