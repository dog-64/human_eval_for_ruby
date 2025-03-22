def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  index1 = planets.index(planet1)
  index2 = planets.index(planet2)
  
  return [] if index1.nil? || index2.nil?

  start_index = [index1, index2].min + 1
  end_index = [index1, index2].max

  planets[start_index...end_index]
end