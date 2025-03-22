def common(l1, l2)
  h = Hash.new { |h, k| h[k] = [] }
  l1.each do |e|
    h[e] << e
  end
  l2.each do |e|
    h[e] << e if h.key?(e)
  end
  h.values.map(&:sort).flatten