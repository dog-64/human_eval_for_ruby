def is_nested?(string)
  n = string.length
  return false if n < 4
  prefix_open = Array.new(n, 0)
  count = 0
  string.chars.each_with_index do | count += 1 if ch == '['
    prefix_open[i] = count
  end
  suffix_close = Array.new(n, 0)
  count = 0
  string.chars.reverse_each.with_index do |ch, rev_i|
    idx = n - 1 - rev_i
    count += 1 if ch == ']'
    suffix_close[idx] = count
  end
  string.chars.each_with_index do |ch, i|
    next unless ch == ']'
    return true if prefix_open[i] >= 2 && suffix_close[i] >= 2
  end
  false
end