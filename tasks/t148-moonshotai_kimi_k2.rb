def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  return [] unless planets.include?(planet1) && planets.include?(planet2)
  
  index1 = planets.index(planet1)
  index2 = planets.index(planet2)
  
  min_index = [index1, index2].min
  max_index = [index1, index2].max
  
  planets[(min_index + 1)...max_index] || []
end