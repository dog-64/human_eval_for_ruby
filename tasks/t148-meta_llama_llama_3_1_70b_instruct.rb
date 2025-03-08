def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  index1, index2 = planets.index(planet1), planets.index(planet2)
  return [] if index1.nil? || index2.nil?

  min_index, max_index = [index1, index2].minmax
  planets[(min_index + 1)...max_index]
end