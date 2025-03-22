def get_row(lst, x)
  result = []
  lst.each_with_index do |row, i|
    row.each_with_index do |element, j|
      if element == x
        result << [i, j]
      end
    end
  end
  result.sort_by! { |pair| pair[0] }.reverse_each { |pair| pair[1] = -pair[1] }
end