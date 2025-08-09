def vowels_count(word)
  return 0 if word.nil? || word.empty?
  count = 0
  last_index = word.length - 1
  word.each_char.with_index do |ch, idx|
    lc = ch.downcase
    if %w[a e i o u].include?(lc)
      count += 1
    elsif lc == 'y' && idx == last_index
      count += 1
    end
  end
  count
end