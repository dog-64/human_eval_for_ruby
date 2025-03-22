def encode_cyclic(s)
    return s if s.length < 3
    result = ""
    i = 0
    while i < s.length - 2
        result += s[i + 1] + s[i + 2] + s[i]
        i += 3
    end
    result += s[i..-1] if i < s.length
    return result
end

def decode_cyclic(s)
    return s if s.length < 3
    result = ""
    i = 0
    while i < s.length - 2
        result += s[i + 2] + s[i + 1] + s[i]
        i += 3
    end
    result += s[i..-1] if i < s.length
    return result
end