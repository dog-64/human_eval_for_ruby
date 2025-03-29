def search(lst)
  lst.group_by(&:itself).map do |num, freq|
    num if freq >= num
  end.compact.max_by(&:itself)
end