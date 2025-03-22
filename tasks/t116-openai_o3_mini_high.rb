def sort_array(arr)
  arr.sort_by do |n|
    if n >= 0
      [n.to_s(2).count("1"), n]
    else
      n
    end
  end
end