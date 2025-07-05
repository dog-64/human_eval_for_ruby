def unique(list)
  seen = Set.new
  result = []
  list.each do |item|
    if !seen.include?(item)
      seen.add(item)
      result << item
    end
  end
  result.sort
end
