def monotonic?(arr)
  if arr.length <= 1
    return true
  end

  increasing = true
  decreasing = true

  arr.each_with_index do |num, index|
    if index > 0 && num < arr[index - 1]
      increasing = false
    elsif index > 0 && num > arr[index - 1]
      decreasing = false
    end
  end

  increasing || decreasing
end
