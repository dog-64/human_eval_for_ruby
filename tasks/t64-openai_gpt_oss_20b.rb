def vowels_count(word)
  count = 0
  return 0 if word.empty?
  word.chars.each_with_index do |ch, idx|
    if 'aeiouAEIOU'.include?(ch)
      count += 1
    elsif (ch == 'y' || ch == 'Y') && idx == word.length - 1
      count += 1
    end
  end
  count
end