def sort_array(arr)
  arr.select { |num| num >= 0 }.sort_by do |num|
    [num.to_s(2).count('1'), num]
  end
end
