def is_cube?(a)
  return true if a == 0 || a == 1 || a == -1

  (-100..100).each do |i|
    return true if i * i * i == a
  end

  false
end