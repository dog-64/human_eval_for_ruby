
def sort_array(arr)
  arr.sort do |a, b|
    a_bits = a.to_s(2).count('1')
    b_bits = b.to_s(2).count('1')
    if a_bits == b_bits
      a <=> b
    else
      a_bits <=> b_bits
    end
  end
end
