def histogram(text)
    freq = Hash.new(0)
    text.each_char do |char|
        if char.match?(/[a-z]/)
            freq[char] += 1
        end
    end
    freq
end