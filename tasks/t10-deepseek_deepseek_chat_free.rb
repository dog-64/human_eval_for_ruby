def make_palindrome(string)
    return string if string == string.reverse

    (0...string.length).each do |i|
        candidate = string + string[0...i].reverse
        return candidate if candidate == candidate.reverse
    end
end
