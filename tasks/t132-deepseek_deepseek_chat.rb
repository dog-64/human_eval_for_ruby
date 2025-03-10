def is_nested?(string)
    stack = []
    nested = false
    string.each_char do |char|
        if char == '['
            stack.push(char)
        elsif char == ']'
            if stack.empty?
                return false
            else
                if stack.size > 1
                    nested = true
                end
                stack.pop
            end
        end
    end
    nested && stack.empty?
end