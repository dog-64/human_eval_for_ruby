def sort_array(arr)
  arr.sort do |a, b|
    binary_a = a.to_s(2).count('1')
    binary_b = b.to_s(2).count('1')

    if binary_a == binary_b
      a <=> b
    else
      binary_a <=> binary_b
    end
  end
end
