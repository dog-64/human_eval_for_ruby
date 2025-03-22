def encrypt(s)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    encrypted_string = ""
    s.each_char do |c|
        index = alphabet.index(c)
        new_index = (index * 2) % 26
        encrypted_string += alphabet[new_index]
    end
    return encrypted_string
end