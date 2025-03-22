def will_it_fly?(q, w)
    return false if q.empty?
    return false unless is_palindrome(q)
    return false if sum(q) > w
    true
end

def is_palindrome(arr)
    arr == arr.reverse
end

def sum(arr)
    arr.reduce(:+)
end