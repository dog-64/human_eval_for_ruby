def add_elements(arr, k)
  arr.first(k).sum do |element|
    if element.abs.to_s.length <= 2
      element
    else
      0
    end
  end
end