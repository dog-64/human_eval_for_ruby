
def parse_nested_parens(paren_string)
    depths = []
    current_depth = 0
    max_depth = 0
    paren_string.chars.each do |char|
        if char == "("
            current_depth += 1
            max_depth = [max_depth, current_depth].max
        elsif char == ")"
            current_depth -= 1
        end
    end
    depths << max_depth
end

def parse_nested_parens(paren_string)
    depths = []
    current_depth = 0
    max_depth = 0
    paren_string.chars.each do |char|
        if char == "("
            current_depth += 1
            max_depth = [max_depth, current_depth].max
        elsif char == ")"
            current_depth -= 1
        end
    end
    depths << max_depth
end

def parse_nested_parens(paren_string)
    depths = []
    current_depth = 0
    max_depth = 0
    paren_string.chars.each do |char|
        if char == "("
            current_depth += 1
            max_depth = [max_depth, current_depth].max
        elsif char == ")"
            current_depth -= 1
        end
    end
    depths << max_depth
end

def parse_nested_parens(paren_string)
    depths = []
    current_depth = 0
    max_depth = 0
    paren_string.chars.each do |char|
        if char == "("
            current_depth += 1
            max_depth = [max_depth, current_depth].max
        elsif char == ")"
            current_depth -= 1
        end
    end
    depths << max_depth
end

def parse_nested_parens(paren_string)
    depths = []
    current_depth = 0
    max_depth = 0
    paren_string.chars.each do |char|
        if char == "("
            current_depth += 1
            max_depth = [max_depth, current_depth].max
        elsif char == ")"
            current_depth -= 1
        end
    end
    depths << max_depth
end