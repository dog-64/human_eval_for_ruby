
def move_one_ball(arr)
  n = arr.length
  return true if n == 0

  count = 0
  (0...n-1).each do |i|
    count += 1 if arr[i] > arr[i+1]
  end

  if count == 0
    true
  elsif count == 1
    arr.last <= arr.first
  else
    false
  end
end