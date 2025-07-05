def select_words(s, n)
  return [] if s.empty?
  consonants = %w(b c d f g h j k l m n p q r s t v w x y z B C D F G H J K L M N P Q R S T V W X Y Z)
  s.split.select do |word|
    word.count { |char| consonants.include?(char) } == n
  end
end