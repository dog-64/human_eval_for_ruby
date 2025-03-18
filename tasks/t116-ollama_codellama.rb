def sort_array(arr)
  arr.sort do |a, b|
    a = a.to_s(2).count("1")
    b = b.to_s(2).count("1")
    if a == b
      a <=> b
    else
      a <=> b
    end
  end
end