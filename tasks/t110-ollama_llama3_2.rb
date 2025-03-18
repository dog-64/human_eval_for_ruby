def exchange(lst1, lst2)
  return "YES" if lst1.any? { |x| x.even? }
  return "NO" unless lst2.any? { |x| x.even? }

  odd = []
  even = []

  lst1.each do |x|
    if x.odd?
      odd << x
    else
      even << x
    end
  end

  lst2.each do |x|
    if x.odd?
      odd << x
    else
      even << x
    end
  end

  lst1 = even + odd
  return "YES" if lst1.all? { |x| x.even? }
  "NO"
end