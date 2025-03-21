
def even_odd_palindrome(n)
    count_even = 0
    count_odd = 0
    for i in 1..n
        if is_palindrome?(i.to_s)
            if i % 2 == 0
                count_even += 1
            else
                count_odd += 1
            end
        end
    end
    return [count_even, count_odd]
end

def is_palindrome?(str)
    str == str.reverse
end