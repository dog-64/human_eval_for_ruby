def by_length(arr)
  arr.select { |num| num.between?(1, 9) }.sort_by(&:reverse).map { |num| num.to_s }
end