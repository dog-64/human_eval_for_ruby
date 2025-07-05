def tri(n)
  result = []
  if n == 0
    result << 1
    return result
  end

  if n == 1
    result << 3
    return result
  end

  (1..n + 1).each do |i|
    if i % 2 == 0
      result << 1 + i / 2
    else
      result << tri(i - 1) + tri(i - 2) + tri(i + 1)
    end
  end

  result
end
