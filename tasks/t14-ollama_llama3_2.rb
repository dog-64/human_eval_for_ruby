def all_prefixes(string)
  string.chars.map { |c| c.to_s }.sort_by(&:length).to_a
end