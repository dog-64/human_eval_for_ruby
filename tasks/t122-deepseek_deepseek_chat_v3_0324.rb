def add_elements(arr, k)
  arr.first(k).sum { |num| num.to_s.gsub(/^-/, '').size <= 2 ? num : 0 }
end