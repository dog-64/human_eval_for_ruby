
def cycpattern_check(a, b)
    n = b.length
    return true if n == 0
    return false if a.length < n

    s = b + b
    base1 = 26
    mod1 = 10**9 + 7
    base2 = 27
    mod2 = 10**9 + 9

    power1 = 1
    power2 = 1
    (n - 1).times do
        power1 = (power1 * base1) % mod1
        power2 = (power2 * base2) % mod2
    end

    hash_set = {}

    hash1 = 0
    hash2 = 0
    (0...n).each do |i|
        c = s[i].ord - 'a'.ord
        hash1 = (hash1 * base1 + c) % mod1
        hash2 = (hash2 * base2 + c) % mod2
    end
    hash_set[[hash1, hash2]] = true

    (1...n).each do |i|
        c_out = s[i - 1].ord - 'a'.ord
        c_in = s[i + n - 1].ord - 'a'.ord

        hash1 = (hash1 - c_out * power1) % mod1
        hash1 = (hash1 * base1 + c_in) % mod1
        hash1 = (hash1 + mod1) % mod1

        hash2 = (hash2 - c_out * power2) % mod2
        hash2 = (hash2 * base2 + c_in) % mod2
        hash2 = (hash2 + mod2) % mod2

        hash_set[[hash1, hash2]] = true
    end

    hash1 = 0
    hash2 = 0
    (0...n).each do |i|
        c = a[i].ord - 'a'.ord
        hash1 = (hash1 * base1 + c) % mod1
        hash2 = (hash2 * base2 + c) % mod2
    end

    return true if hash_set.key?([hash1, hash2])

    (1...a.length - n + 1).each do |i|
        c_out = a[i - 1].ord - 'a'.ord
        c_in = a[i + n - 1].ord - 'a'.ord

        hash1 = (hash1 - c_out * power1) % mod1
        hash1 = (hash1 * base1 + c_in) % mod1
        hash1 = (hash1 + mod1) % mod1

        hash2 = (hash2 - c_out * power2) % mod2
        hash2 = (hash2 * base2 + c_in) % mod2
        hash2 = (hash2 + mod2) % mod2

        return true if hash_set.key?([hash1, hash2])
    end

    false
end