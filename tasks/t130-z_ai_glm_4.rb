
def tri(n)
  result = []
  (0..n).each do |i|
    if i == 0
      result << 1
    elsif i == 1
      result << 3
    else
      if i.even?
        result << 1 + i / 2
      else
        result << result[i-1] + result[i-2] + (1 + (i+1)/2)
      end
    end
  end
  result
end