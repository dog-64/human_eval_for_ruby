def is_sorted?(lst)
    lst == lst.sort && lst.uniq.size == lst.size
end