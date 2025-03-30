
def count_distinct_characters(string)
  string.downcase.each_char.with_object(Set.new) { |c, s| s.add(c) }.size
end

 