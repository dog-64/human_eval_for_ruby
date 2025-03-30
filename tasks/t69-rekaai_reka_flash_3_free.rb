
def search(lst)
  frequency = lst.group_by { |x| x }.transform_values(&:count)
  candidates = frequency.select { |num, count| count >= num }.keys
  candidates.max || -1
end

 