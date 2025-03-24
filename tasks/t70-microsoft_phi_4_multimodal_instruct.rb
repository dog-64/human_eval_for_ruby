def strange_sort_list(lst)
  return [] if lst.empty?
  sorted = []
  lst.sort_by.with_index { |_, i| i.even? ? -1 : 1 }.each { |_, value| sorted << value }
  sorted
end
