def is_sorted?(lst)
    return true if lst.empty?
    (lst.size - 1).times do |i|
        return false unless lst[i] <= lst[i + 1]
    end
    true
end