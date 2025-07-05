def max_element(list)
  if list.empty?
    return nil
  end

  max_val = list[0]
  list.each do |element|
    if element > max_val
      max_val = element
    end
  end

  max_val
end
