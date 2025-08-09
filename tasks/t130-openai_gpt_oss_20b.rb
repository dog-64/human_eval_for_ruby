def tri(n)
  tri = Array.new(n + 2)
  tri[0] = 1
  tri[1] = 3
  (2..n).each do |i|
    if i.even?
      tri[i] = 1 + i / 2
    else
      tri[i + 1] ||= 1 + (i + 1) / 2
      tri[i] = tri[i - 1] + tri[i - 2] + tri[i + 1]
    end
  end
  tri[0..n]
end