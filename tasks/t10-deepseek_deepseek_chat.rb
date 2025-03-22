def make_palindrome(string)
    return string if string == string.reverse
    max_len = 0
    (0...string.length).each do |i|
        if string[i..-1] == string[i..-1].reverse
            max_len = string.length - i
            break
        end
    end
    string + string[0...string.length - max_len].reverse
end