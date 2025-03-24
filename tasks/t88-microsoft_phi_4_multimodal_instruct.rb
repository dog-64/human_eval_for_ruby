def sort_array(array)
  return array.dup.sort! if (array.first + array.last).odd?
  array.dup.sort!.reverse!
end
```