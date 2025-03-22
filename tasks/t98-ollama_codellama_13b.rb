def count_upper(s)
  s.each_char.with_index.count do |c, i|
    c.upcase == c && i.even?
  end
end