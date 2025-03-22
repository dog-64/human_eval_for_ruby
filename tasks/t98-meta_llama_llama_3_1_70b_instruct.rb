def count_upper(s)
  s.chars.count { |c| ['A', 'E', 'I', 'O', 'U'].include?(c) && s.index(c).even? }
end