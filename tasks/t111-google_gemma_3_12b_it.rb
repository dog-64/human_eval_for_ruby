def histogram(text)
  counts = Hash.new(0)
  text.downcase.gsub(/[^a-z]/, '').split.each do |char|
    counts[char] += 1
  end
  counts
end
