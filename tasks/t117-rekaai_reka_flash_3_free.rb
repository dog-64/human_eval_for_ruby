 

def select_words(s, n)
  return [] if s.empty?

  s.split.select do |word|
    vowels = %w[a e i o u]
    word.each_char.count { |c| !vowels.include?(c.downcase) } == n
  end
end

 