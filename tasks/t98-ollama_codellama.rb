def count_upper(s)
  s.each_char.with_index.count { |c, i| c.upcase? && i.even? }
end