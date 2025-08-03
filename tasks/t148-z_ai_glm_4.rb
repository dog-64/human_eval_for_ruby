
def bf(planet1, planet2)
  planets_order = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  
  return [] unless planets_order.include?(planet1) && planets_order.include?(planet2)
  
  index1 = planets_order.index(planet1)
  index2 = planets_order.index(planet2)
  
  start_index = [index1, index2].min
  end_index = [index1, index2].max
  
  planets_order[start_index + 1...end_index]
end