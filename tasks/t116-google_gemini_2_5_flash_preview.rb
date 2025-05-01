def sort_array(arr)
  arr.sort do |a, b|
    if a >= 0 && b >= 0
      count_a = a.to_s(2).count('1')
      count_b = b.to_s(2).count('1')
      if count_a == count_b
        a <=> b
      else
        count_a <=> count_b
      end
    else
      a <=> b
    end
  end
end
