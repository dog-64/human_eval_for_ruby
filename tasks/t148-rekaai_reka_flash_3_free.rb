
def bf(planet1, planet2)
  order = %w[Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune]
  return [] unless order.include?(planet1) && order.include?(planet2)

  start = [order.index(planet1), order.index(planet2)].min
  end_idx = [order.index(planet1), order.index(planet2)].max

  order[start + 1...end_idx]
end

 