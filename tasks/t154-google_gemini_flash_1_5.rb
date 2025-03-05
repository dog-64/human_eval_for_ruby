def cycpattern_check(a, b)
  return true if b.empty?
  return false if a.empty?

  b_permutations = []
  b.length.times do |i|
    b_permutations << b.slice(i..-1) + b.slice(0...i)
  end

  b_permutations.any? { |perm| a.include?(perm) }
end
