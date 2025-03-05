def histogram(text)
  text.each_char.with_object(Hash.new(0)) { |char, hash| hash[char] += 1 if char =~ /[a-z]/ }.select { |_, count| count == _1.values.max }
end