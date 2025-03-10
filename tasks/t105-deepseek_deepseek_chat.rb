def by_length(arr)
    numbers_to_words = {
        1 => "One",
        2 => "Two",
        3 => "Three",
        4 => "Four",
        5 => "Five",
        6 => "Six",
        7 => "Seven",
        8 => "Eight",
        9 => "Nine"
    }
    
    filtered = arr.select { |x| x.between?(1, 9) }
    sorted = filtered.sort.reverse
    sorted.map { |x| numbers_to_words[x] }
end