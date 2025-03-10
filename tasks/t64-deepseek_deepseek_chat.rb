def vowels_count(word)
    vowels = ['a', 'e', 'i', 'o', 'u']
    count = 0
    word.downcase.each_char do |char|
        count += 1 if vowels.include?(char)
    end
    count += 1 if word.downcase.end_with?('y') && word.downcase[-1] == 'y'
    count
end