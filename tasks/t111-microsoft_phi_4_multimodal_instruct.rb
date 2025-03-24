def histogram(text)
  text.downcase.chars.select { |char| char =~ /[a-z]/ }.each_with_object(Hash.new(0)) do |char, counts|
    counts[char] += 1
  end
end