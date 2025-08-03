
def add_elements(arr, k)
  selected = arr.take(k)
  sum = 0
  selected.each do |num|
    num_str = num.abs.to_s
    if num_str.length <= 2
      sum += num
    end
  end
  sum
end