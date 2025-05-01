def add_elements(arr, k)
  sum = 0
  arr[0...k].each do |element|
    if element.abs.to_s.length <= 2
      sum += element
    end
  end
  sum
end