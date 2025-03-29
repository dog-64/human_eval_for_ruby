def even_odd_count(num)
  num.abs.to_s.chars.map(&:to_i).group_by(&:odd?).map { |k, v| [v.count, k ? 1 : 0] }.sum
end