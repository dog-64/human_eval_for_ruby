def reverse_delete(s, c)
    result = s.gsub(Regexp.new(c), '')
    return [result, result == result.reverse]
end