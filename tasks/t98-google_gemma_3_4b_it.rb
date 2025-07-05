def count_upper(s)
  count = 0
  (0..s.length - 1).each do |i|
    if i.even? && ['A', 'E', 'I', 'O', 'U'].include?(s[i])
      count += 1
    end
  end
  count
end
