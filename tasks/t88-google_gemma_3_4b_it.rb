def sort_array(array)
  new_array = array.dup
  if new_array.empty?
    new_array
  else
    if new_array[0] + new_array[-1] % 2 != 0
      new_array.sort!
    else
      new_array.sort_by { |x| -x }
    end
    new_array
  end
end
