def select_words(s, n)
  vowels = /[AEIOUaeiou]/
  s.split.select do |word|
    word.count { |ch| ch =~ /[A-Za-z]/ && ch !~ vowels } == n
  end
end