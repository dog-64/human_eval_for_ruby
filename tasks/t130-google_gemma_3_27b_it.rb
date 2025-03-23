def tri(n)
  result = [1]
  if n == 0
    return result
  end
  result << 3
  if n == 1
    return result
  end
  result << 2
  if n == 2
    return result
  end

  (3..n).each do |i|
    if i % 2 == 0
      result << 1 + i / 2
    else
      result << result[i - 1] + result[i - 2] + result[i + 1]
    end
  end
  return result
end