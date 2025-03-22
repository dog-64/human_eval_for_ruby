
def match_parens(lst)
    open_count = 0
    close_count = 0
    lst[0].each_char do |c|
        if c == '('
            open_count += 1
        else
            close_count += 1
        end
    end
    lst[1].each_char do |c|
        if c == ')'
            close_count += 1
        else
            open_count += 1
        end
    end
    if open_count == close_count
        return "Yes"
    else
        return "No"
    end
end