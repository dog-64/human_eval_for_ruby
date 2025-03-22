def separate_paren_groups(paren_string)
    groups = []
    current_group = ""
    balance = 0
    paren_string.each_char do |char|
        if char == "("
            balance += 1
            current_group += char
        elsif char == ")"
            balance -= 1
            current_group += char
            if balance == 0
                groups << current_group
                current_group = ""
            end
        elsif char != " " || balance > 0
            current_group += char
        end
    end
    return groups
end