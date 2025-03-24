def count_upper(s)
  count = 0
  s.each_char.with_index do |char, index|
    count += 1 если char.match?(/[AEIOU]/) && index.even?
  end
  count
end