def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = []
  temp_list = lst.sort

  while !temp_list.empty?
    sorted_list << temp_list.shift
    sorted_list << temp_list.pop unless temp_list.empty?
  end

  sorted_list
end
