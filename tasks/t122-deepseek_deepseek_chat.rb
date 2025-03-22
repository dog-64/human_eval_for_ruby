def add_elements(arr, k)
  arr[0...k].select { |x| x.to_s.length <= 2 }.sum
end