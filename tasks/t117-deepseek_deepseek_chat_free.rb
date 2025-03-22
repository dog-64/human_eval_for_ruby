def select_words(s, n)
  consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
  words = s.split
  words.select do |word|
    count = word.downcase.chars.count { |c| consonants.include?(c) }
    count == n
  end
end