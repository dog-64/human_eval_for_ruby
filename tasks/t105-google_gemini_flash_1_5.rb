def by_length(arr)
  nums = arr.select { |x| x.between?(1, 9) }.sort.reverse
  nums.map { |num| num.to_s.capitalize }
end
