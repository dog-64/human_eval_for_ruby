
def smallest_change(arr)
  count = 0
  (0...arr.length/2).each do |i|
    count += 1 if arr[i] != arr[-(i+1)]
  end
  count
end

 