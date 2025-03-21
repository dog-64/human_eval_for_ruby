def sort_array(arr)
    arr.sort do |a, b|
        a_binary = a.to_s(2).count("1")
        b_binary = b.to_s(2).count("1")
        if a_binary == b_binary
            a <=> b
        else
            a_binary <=> b_binary
        end
    end
end