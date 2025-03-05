def add_elements(arr, k)
  sum = 0
  arr[0...k].each do |num|
    if num.to_s.length <= 2 && num.to_s.length > 0 || (num < 0 && num.to_s.length <= 3 && num.to_s.length > 0)
      sum += num
    end
  end
  sum
end