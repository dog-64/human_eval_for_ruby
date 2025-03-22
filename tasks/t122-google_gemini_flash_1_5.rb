def add_elements(arr, k)
  arr[0...k].select { |x| x.abs < 100 }.sum
end
