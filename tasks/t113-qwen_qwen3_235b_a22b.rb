def odd_count(strings)
  template = "the number of odd elements Xn the strXng X of the Xnput."
  strings.map do |s|
    count = s.count('13579')
    template.gsub('X', count.to_s)
  end
end