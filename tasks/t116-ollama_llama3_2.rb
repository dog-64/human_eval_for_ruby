def sort_array(arr)
  arr.sort do |a, b|
    bin_a = a.to_s(2).count('1')
    bin_b = b.to_s(2).count('1')
    bin_a <=> bin_b || a <=> b
  end
end