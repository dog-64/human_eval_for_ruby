
def find_max(words)
    return "" if words.empty?

    max_unique = 0
    result = nil

    words.each do |word|
        count = word.chars.uniq.size
        if count > max_unique
            max_unique = count
            result = word
        elsif count == max_unique
            if word < result
                result = word
            end
        end
    end

    result
end