def count_distinct_characters(string)
  string = string.downcase
  characters = {}
  string.each_char do |c|
    if !characters[c].nil?
      characters[c] += 1
    else
      characters[c] = 1
    end
  end
  return characters.size
end