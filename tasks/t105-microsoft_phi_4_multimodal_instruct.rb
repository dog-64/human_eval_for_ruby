def by_length(arr)
  arr.select! { |n| n.between?(1, 9) }
  arr.sort!.reverse!
  arr.map { |n| n.to_s }
end