
def exchange(lst1, lst2)
    return "NO" if lst1.any? { |x| x % 2 != 0 } || lst2.any? { |x| x % 2 != 0 }
    "YES"
end