def search(lst)
  lst.max_by { |num| [num, lst.count(num)].max } || -1
end