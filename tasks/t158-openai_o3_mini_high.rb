def find_max(words)
  return "" if words.empty?
  words.sort_by do |word|
    count = word.chars.select { |c| c =~ /[a-z]/ }.uniq.size
    [-count, word]
  end.first
end