def sort_third(l)
  l.each_slice(3).map { |a| a.sort }.flatten
end